#pragma once

#include "compress/compress.h"

#include "third_party/zstd/lib/zstd.h"

namespace logger {
namespace compress {

class ZstdCompress final : public Compression {
 public:
  ZstdCompress();

  ~ZstdCompress() override;

  size_t Compress(const void* input, size_t input_size, void* output, size_t output_size) override;

  std::string Decompress(const void* data, size_t size) override;

  void ResetStream() override;

  size_t CompressedBound(size_t input_size) override;

 private:
  void ResetUncompressStream_();

 private:
  ZSTD_CCtx* cctx_;
  ZSTD_DCtx* dctx_;
};

}  // namespace compress
}  // namespace logger
