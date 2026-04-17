# Effective Logger - 高性能异步加密日志系统

一个面向生产环境设计的 C++17 日志库，核心特性是**异步写入 + 压缩 + 加密 + 崩溃恢复**。单线程写入 2KB 日志可达百万级 QPS，即使进程异常崩溃也不丢数据。

## 核心特性

- **双缓冲异步刷盘**  主线程零阻塞，压缩/加密/IO 全部后台执行
- **mmap 崩溃安全**   利用内存映射文件，程序 crash 后重启自动恢复未落盘数据
- **ECDH + AES 加密** 非对称协商会话密钥，即使日志泄露也无法解密
- **Zstd 流式压缩**   存储空间节省 70%+
- **文件轮转 + 淘汰** 按大小切分，按总量 LRU 淘汰，磁盘不会爆
- **跨平台**          Windows / Linux / macOS，CMake 构建
- **零开销抽象**      编译期宏消除低级别日志，Release 零成本

## 项目结构

```
logger-tutorial/
├── logger/                   核心库 (~2400 LOC)
│   ├── log_handle.*          日志入口，level 过滤 + Sink 分发
│   ├── log_factory.*         单例工厂，全局 Handle 管理
│   ├── log_msg.*             日志消息结构
│   ├── logger.h              用户宏接口 (EXT_LOG_INFO 等)
│   ├── sinks/
│   │   ├── sink.h            Sink 抽象接口
│   │   ├── console_sink.*    控制台 Sink
│   │   └── effective_sink.*  核心 Sink：压缩+加密+mmap+异步
│   ├── formatter/            格式化器（fmt 库）
│   ├── compress/             Zstd / Zlib 压缩抽象
│   ├── crypt/                AES 加密 + ECDH 密钥协商
│   ├── mmap/                 跨平台内存映射封装
│   ├── context/              线程池 + 任务调度
│   └── utils/                跨平台系统调用封装
├── decode/                   离线解密工具
├── example/                  示例程序
└── script/                   构建脚本
```

## 架构设计

```
                   ┌──────────────┐
  业务线程         │   LOG_INFO   │  编译期宏，Release 下低级别被完全消除
    │              └──────┬───────┘
    ▼                     │
┌───────────┐      ┌──────▼───────┐
│ LogHandle │─────▶│  EffectiveSink.Log()       │ 同步阶段（加锁）
└───────────┘      │  ┌──────────────────────┐  │
                   │  │ 1. Format (fmt)      │  │
                   │  │ 2. Zstd 压缩          │  │
                   │  │ 3. AES 加密           │  │
                   │  │ 4. 写 master_cache   │  │ ←── mmap 内存，崩溃不丢
                   │  └──────────────────────┘  │
                   │         │  达到 80% 容量     │
                   │         ▼                  │
                   │  ┌──────────────────────┐  │
                   │  │ swap(master, slave)  │  │ 原子切换，主线程继续写
                   │  └──────────┬───────────┘  │
                   └─────────────┼──────────────┘
                                 │ POST_TASK
                                 ▼
                         ┌────────────────┐
                         │   ThreadPool   │     异步阶段
                         │  CacheToFile_  │     slave → 磁盘文件
                         │  + 文件轮转     │
                         │  + LRU 淘汰    │     （5 分钟周期任务）
                         └────────────────┘
```

### 关键设计点

**1. 双 mmap 缓冲 —— 零拷贝 + 崩溃安全**

`master_cache` 供主线程写入，`slave_cache` 供后台线程刷盘。swap 只是交换两个智能指针，O(1)。mmap 的数据由 OS 页缓存管理，即使进程崩溃，内核也会异步写回。程序重启时构造函数主动检测：

```cpp
// 重启后自动恢复上次未刷盘的数据
if (!slave_cache_->Empty()) { PrepareToFile_(); WAIT_TASK_IDLE(...); }
if (!master_cache_->Empty()) { SwapCache_(); PrepareToFile_(); }
```

**2. ECDH + AES 混合加密**

服务端持有 ECDH 长期密钥对，公钥硬编码进客户端。客户端启动时生成临时密钥对，与服务端公钥协商共享密钥，用于 AES 加密日志。每个日志文件的 `ChunkHeader` 中保存客户端公钥：

```
┌────────────────────────────────────────────┐
│ ChunkHeader: magic | size | client_pub_key │  ← 服务端用私钥+这个公钥恢复会话密钥
├────────────────────────────────────────────┤
│ Encrypted ( Zstd ( Formatted log items ) ) │
├────────────────────────────────────────────┤
│ ChunkHeader ...                            │  ← 每次 flush 一个 chunk
└────────────────────────────────────────────┘
```

即便黑客拿到日志文件，没有服务端私钥也无法解密。

**3. 流式压缩状态管理**

Zstd 使用流式压缩跨日志条目共享字典，压缩率更高。刷盘后 `ResetStream()` 重置状态，保证每个 chunk 独立可解码：

```cpp
if (master_cache_->Empty()) { compress_->ResetStream(); }  // 新 chunk 开始
```

**4. 编译期零开销**

```cpp
#if LOGGER_ACTIVE_LEVEL <= LOGGER_LEVEL_DEBUG
#define EXT_LOG_DEBUG(...) LOG_LOGGER_DEBUG(...)
#else
#define EXT_LOG_DEBUG(...) (void)0    // Release 下完全消失
#endif
```

## 快速开始

### 构建

```bash
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . -j
```

### 使用

```cpp
#include "logger/log_handle.h"
#include "logger/sinks/effective_sink.h"

int main() {
  logger::EffectiveSink::Conf conf;
  conf.dir         = "/var/log/myapp";
  conf.prefix      = "app";
  conf.pub_key     = "04827405..."; // 服务端 ECDH 公钥
  conf.single_size = logger::megabytes{4};
  conf.total_size  = logger::megabytes{100};
  conf.interval    = std::chrono::minutes{5};

  auto sink = std::make_shared<logger::EffectiveSink>(conf);
  logger::LogHandle handle({sink});

  handle.Log(logger::LogLevel::kInfo, {}, "hello world");
  sink->Flush();
}
```

### 解密

```bash
./decode --input app_20260417120000.log \
         --private-key FAA5BBE9... \
         --output app.txt
```

## 性能

测试环境：Apple Silicon（macOS arm64）/ Release 构建 / APFS SSD / `example/bench` 端到端压测（含压缩 + ECDH + AES + 落盘）。

| 场景                      | 线程 | 日志数    | 单条  | 耗时(ms) | QPS     | 吞吐(MB/s) | ns/log | 磁盘(MB) | 压缩比 |
|---------------------------|-----|-----------|-------|----------|---------|------------|--------|----------|--------|
| 单线程 2KB × 100万        |  1  | 1,000,000 | 2048  | 2170     | 460,810 |   900.0    | 2170   | 23.97    |  81x   |
| 单线程 4KB × 50万         |  1  |   500,000 | 4096  | 1234     | 405,080 |  1582.3    | 2469   | 12.52    | 156x   |
| 4 线程 2KB × 25万/线程    |  4  | 1,000,000 | 2048  | 3552     | 281,538 |   549.9    | 3552   | 25.17    |  78x   |
| 8 线程 2KB × 12.5万/线程  |  8  | 1,000,000 | 2048  | 3641     | 274,638 |   536.4    | 3641   | 25.56    |  76x   |

说明：
- `raw` = 日志条数 × 单条大小（压缩/加密前）
- `disk` = 实际写盘字节（Zstd 压缩 + AES 加密后）
- 压缩比 = raw / disk；AES 会带来少量膨胀，实际压缩增益由 Zstd 贡献

结论：
- 单线程 2KB 场景稳定在 ~46 万 QPS / 900 MB/s，含压缩+加密+落盘
- 4KB 日志负载下压缩比跃升至 156x（模板化日志重复度高）
- 多线程吞吐**未随线程数线性扩展**，详见下方 "Known Issues"

## Known Issues

### Zstd 流式压缩器并发不安全（已在 benchmark 中暴露）

多线程场景（4 / 8 线程）下 stderr 会周期性出现 `EffectiveSink::Log: compress failed`，同时吞吐反而低于单线程：单线程 46 万 QPS → 多线程 ~28 万 QPS。

**根因：** `EffectiveSink` 内部持有单个 `ZSTD_CStream` 共享实例，多线程并发调用 `ZSTD_compressStream2` 会导致内部状态机竞态，部分日志落盘失败。

**修复方向（任选其一）：**
1. **每线程独立 `ZSTD_CCtx`**（推荐，无锁，吞吐最优）——用 `thread_local` 或线程池绑定
2. **mutex 保护压缩路径**（实现简单，但退化成串行压缩，吞吐上限受限）

面向后续版本会优先采用方案 1。

## 依赖

- C++17
- [fmt](https://github.com/fmtlib/fmt) 11.0.2 — 格式化
- [zstd](https://github.com/facebook/zstd) 1.5.6 — 压缩
- zlib 1.2.13 — 备用压缩
- [cryptopp](https://github.com/weidai11/cryptopp) 8.9.0 — ECDH + AES
- protobuf 21.8 — 结构化日志（可选）

## 后续演进

- [ ] lock-free SPSC 队列替换 mutex + 双缓冲，极致降延迟
- [ ] 支持日志等级运行时热更新
- [ ] OpenTelemetry span 集成
- [ ] 网络 Sink：直发 Kafka / Loki
- [ ] Python binding（pybind11），用于 AI Agent 链路追踪

## 作者

独立开发。欢迎提 Issue 交流。
