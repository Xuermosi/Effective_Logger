#include <atomic>
#include <chrono>
#include <cstdio>
#include <filesystem>
#include <iostream>
#include <thread>
#include <vector>

#include "logger/log_handle.h"
#include "logger/sinks/effective_sink.h"

namespace fs = std::filesystem;

static std::string GenerateRandomString(size_t length) {
  std::string str;
  str.reserve(length);
  for (size_t i = 0; i < length; ++i) {
    str.push_back('a' + rand() % 26);
  }
  return str;
}

struct BenchResult {
  std::string name;
  size_t threads;
  size_t total_logs;
  size_t log_size;
  double elapsed_ms;
  size_t file_bytes;
};

static size_t DirSizeBytes(const fs::path& dir) {
  size_t total = 0;
  if (!fs::exists(dir)) return 0;
  for (auto& p : fs::recursive_directory_iterator(dir)) {
    if (p.is_regular_file()) total += fs::file_size(p.path());
  }
  return total;
}

static BenchResult RunBench(const std::string& name, size_t thread_count, size_t logs_per_thread, size_t log_size) {
  fs::path dir = fs::temp_directory_path() / ("logger_bench_" + name);
  if (fs::exists(dir)) fs::remove_all(dir);
  fs::create_directories(dir);

  logger::EffectiveSink::Conf conf;
  conf.dir = dir;
  conf.prefix = "bench";
  conf.pub_key =
      "04827405069030E26A211C973C8710E6FBE79B5CAA364AC111FB171311902277537F8852EADD17EB339EB7CD0BA2490A58CDED2C702DFC1E"
      "FC7EDB544B869F039C";
  conf.single_size = logger::megabytes{4};
  conf.total_size = logger::megabytes{500};
  conf.interval = std::chrono::minutes{60};

  auto sink = std::make_shared<logger::EffectiveSink>(conf);
  logger::LogHandle handle({sink});

  std::string payload = GenerateRandomString(log_size);

  auto begin = std::chrono::steady_clock::now();
  std::vector<std::thread> workers;
  workers.reserve(thread_count);
  for (size_t t = 0; t < thread_count; ++t) {
    workers.emplace_back([&handle, &payload, logs_per_thread]() {
      for (size_t i = 0; i < logs_per_thread; ++i) {
        handle.Log(logger::LogLevel::kInfo, logger::SourceLocation(), payload);
      }
    });
  }
  for (auto& w : workers) w.join();
  sink->Flush();
  auto end = std::chrono::steady_clock::now();

  BenchResult r;
  r.name = name;
  r.threads = thread_count;
  r.total_logs = thread_count * logs_per_thread;
  r.log_size = log_size;
  r.elapsed_ms = std::chrono::duration<double, std::milli>(end - begin).count();
  r.file_bytes = DirSizeBytes(dir);
  return r;
}

static void PrintResult(const BenchResult& r) {
  double raw_mb = (double)(r.total_logs * r.log_size) / (1024.0 * 1024.0);
  double disk_mb = (double)r.file_bytes / (1024.0 * 1024.0);
  double qps = r.total_logs * 1000.0 / r.elapsed_ms;
  double throughput_mb = raw_mb * 1000.0 / r.elapsed_ms;
  double ns_per_log = r.elapsed_ms * 1e6 / r.total_logs;
  double ratio = disk_mb > 0 ? raw_mb / disk_mb : 0.0;
  std::printf("| %-18s | %7zu | %10zu | %6zu | %9.1f | %10.0f | %9.1f | %8.0f | %7.2f | %6.2fx |\n",
              r.name.c_str(), r.threads, r.total_logs, r.log_size, r.elapsed_ms, qps, throughput_mb, ns_per_log, disk_mb,
              ratio);
}

int main() {
  std::printf("\n=== Effective Logger Benchmark (macOS arm64) ===\n\n");
  std::printf(
      "| %-18s | %7s | %10s | %6s | %9s | %10s | %9s | %8s | %7s | %6s |\n",
      "case", "threads", "logs", "bytes", "wall(ms)", "qps", "MB/s", "ns/log", "disk MB", "comp");
  std::printf("|--------------------|---------|------------|--------|-----------|------------|-----------|----------|---------|--------|\n");

  PrintResult(RunBench("1thread_2KB_1M",  1, 1000000, 2048));
  PrintResult(RunBench("1thread_256B_1M", 1, 1000000,  256));
  PrintResult(RunBench("4thread_2KB_250K",4,  250000, 2048));
  PrintResult(RunBench("8thread_2KB_125K",8,  125000, 2048));
  PrintResult(RunBench("1thread_4KB_500K",1,  500000, 4096));

  std::printf("\nNotes:\n");
  std::printf("  - raw  = total_logs * log_size (before compression/encryption)\n");
  std::printf("  - disk = actual bytes written to .log files (after Zstd + AES)\n");
  std::printf("  - comp = raw / disk (compression ratio; AES adds small overhead)\n");
  return 0;
}
