

#include <cstring>
#include <iostream>

#include "logger/compress/zstd_compress.h"
#include "logger/third_party/zstd/lib/zstd.h"

typedef struct {
  void* fBuffer;
  void* cBuffer;
  size_t fBufferSize;
  size_t cBufferSize;
  ZSTD_CCtx* cctx;
} resources;

resources Init(size_t fBufferSize = 100) {
  resources res;
  res.fBufferSize = fBufferSize;
  res.cBufferSize = ZSTD_compressBound(res.fBufferSize);
  res.fBuffer = malloc(res.fBufferSize);
  res.cBuffer = malloc(res.cBufferSize);
  res.cctx = ZSTD_createCCtx();

  ZSTD_CCtx_setParameter(res.cctx, ZSTD_c_compressionLevel, 5);
  return res;
}

void Free(resources res) {
  free(res.fBuffer);
  free(res.cBuffer);
  ZSTD_freeCCtx(res.cctx);
}

#define CHECK(cond, ...)                                                      \
  do {                                                                        \
    if (!(cond)) {                                                            \
      fprintf(stderr, "%s:%d CHECK(%s) failed: ", __FILE__, __LINE__, #cond); \
      fprintf(stderr, "" __VA_ARGS__);                                        \
      fprintf(stderr, "\n");                                                  \
      exit(1);                                                                \
    }                                                                         \
  } while (0)

#define CHECK_ZSTD(fn, ...)                                  \
  do {                                                       \
    size_t const err = (fn);                                 \
    CHECK(!ZSTD_isError(err), "%s", ZSTD_getErrorName(err)); \
  } while (0)

std::string Decompress(const std::string& input) {
  size_t out_size = out_size = 20 * 1024 * 1024;
  void* const r_buff = malloc(out_size);
  size_t dSize = ZSTD_decompress(r_buff, out_size, input.c_str(), input.size());
  CHECK_ZSTD(dSize);
  std::string output;
  output.append((char*)r_buff, dSize);
  free(r_buff);
  return output;
}

bool IsCompressed(const void* input, size_t input_size) {
  if (!input) {
    printf("input is empty");
    return false;
  }

  if (input_size < 4) {
    printf("input size is too small");
    return false;
  }

  const uint8_t kMagicNumberBigEndian[] = {0x28, 0xb5, 0x2f, 0xfd};
  const uint8_t kMagicNumberLittleEndian[] = {0xfd, 0x2f, 0xb5, 0x28};
  if (memcmp(input, kMagicNumberBigEndian, sizeof(kMagicNumberBigEndian)) == 0) {
    return true;
  }

  if (memcmp(input, kMagicNumberLittleEndian, sizeof(kMagicNumberLittleEndian)) == 0) {
    return true;
  }

  return false;
}

std::string Decompress2(const std::string& input) {
  size_t buff_in_size = ZSTD_DStreamInSize();
  size_t buff_out_size = ZSTD_DStreamOutSize();
  void* const buff_in = malloc(buff_in_size);
  void* const buff_out = malloc(buff_out_size);

  ZSTD_DCtx* const dctx = ZSTD_createDCtx();
  std::string output;

  if (IsCompressed(input.c_str() + 92, input.size())) {
    std::cout << "input is compressed" << std::endl;
  } else {
    std::cout << "input is not compressed" << std::endl;
  }

  ZSTD_inBuffer input_buffer = {input.c_str() + 92, 92, 0};
  while (input_buffer.pos < input_buffer.size) {
    ZSTD_outBuffer output_buffer = {buff_out, buff_out_size, 0};
    size_t const ret = ZSTD_decompressStream(dctx, &output_buffer, &input_buffer);
    if (ZSTD_isError(ret) != 0) {
      std::cout << "ZSTD_decompressStream failed, error code: " << ret << std::endl;
      break;
    }
    output.append((char*)buff_out, output_buffer.pos);
  }
  return output;
}

std::string Compress() {
  std::string input1 =
      "string11167890987657890string11167890987657890string11167890987657890str"
      "ing11167890987657890";
  std::string input2 =
      "string222333336666666string11167890987657890string11167890987657890strin"
      "g11167890987657890";
  std::string input3 =
      "string333333333333333333333333string11167890987657890string1116789098765"
      "7890string11167890987657890";

  std::string output;
  static size_t s = 100;
  s += 100;
  resources res = Init(s);
  size_t cSize = ZSTD_compressCCtx(res.cctx, res.cBuffer, res.cBufferSize, input1.c_str(), input1.size(), 1);
  output.append((char*)res.cBuffer, cSize);
  cSize = ZSTD_compressCCtx(res.cctx, res.cBuffer, res.cBufferSize, input2.c_str(), input2.size(), 1);
  output.append((char*)res.cBuffer, cSize);
  cSize = ZSTD_compressCCtx(res.cctx, res.cBuffer, res.cBufferSize, input3.c_str(), input3.size(), 1);
  output.append((char*)res.cBuffer, cSize);

  Free(res);

  size_t in_size = input1.size() + input2.size() + input3.size();
  size_t out_size = output.size();
  std::cout << "in_size: " << in_size << ", out_size: " << out_size << ", ratio: " << (float)out_size / in_size
            << std::endl;
  return output;
}

std::string GenerateRandomString(int length) {
  std::string str;
  str.reserve(length);
  for (int i = 0; i < length; ++i) {
    str.push_back('a' + rand() % 26);
  }
  return str;
}

std::string Compress2() {
  std::string input1 = "string11167890987657890";
  std::string input2 = "string222333336666666";
  std::string input3 = "string333333333333333333333333";

  std::string output;
  resources res = Init();
  ZSTD_inBuffer input = {input1.c_str(), input1.size(), 0};
  ZSTD_outBuffer output_buffer = {res.cBuffer, res.cBufferSize, 0};
  size_t size = ZSTD_compressStream2(res.cctx, &output_buffer, &input, ZSTD_e_flush);
  output.append((char*)res.cBuffer, output_buffer.pos);

  input = {input2.c_str(), input2.size(), 0};
  output_buffer = {res.cBuffer, res.cBufferSize, 0};
  size = ZSTD_compressStream2(res.cctx, &output_buffer, &input, ZSTD_e_flush);
  output.append((char*)res.cBuffer, output_buffer.pos);

  input = {input3.c_str(), input3.size(), 0};
  output_buffer = {res.cBuffer, res.cBufferSize, 0};
  size = ZSTD_compressStream2(res.cctx, &output_buffer, &input, ZSTD_e_flush);
  output.append((char*)res.cBuffer, output_buffer.pos);

  std::string input4 = GenerateRandomString(20);
  input = {input4.c_str(), input4.size(), 0};
  output_buffer = {res.cBuffer, res.cBufferSize, 0};
  size = ZSTD_compressStream2(res.cctx, &output_buffer, &input, ZSTD_e_flush);
  output.append((char*)res.cBuffer, output_buffer.pos);

  size_t in_size = input1.size() + input2.size() + input3.size() + input4.size();
  size_t out_size = output.size();
  std::cout << "in_size: " << in_size << ", out_size: " << out_size << ", ratio: " << (float)out_size / in_size
            << std::endl;

  Free(res);
  return output;
}
void Test() {
  // compress
  std::string input;

  input += Compress2();
  input += Compress2();
  // input += Compress();
  // input += Compress();
  // input += Compress();
  // input += Compress();
  // input += Compress();
  // input += Compress();
  // input += Compress();
  // input += Compress();
  // input += Compress();
  // input += Compress();

  // decompress
  std::string output = Decompress2(input);
  std::cout << output << std::endl;
}

int main() {
  Test();
  return 0;
}
