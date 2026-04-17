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
| 单线程 2KB × 100万        |  1  | 1,000,000 | 2048  | 2214     | 451,688 |   882.2    | 2214   | 23.97    |  81x   |
| 单线程 256B × 100万       |  1  | 1,000,000 |  256  | 2046     | 488,762 |   119.3    | 2046   | 23.91    |  10x   |
| 单线程 4KB × 50万         |  1  |   500,000 | 4096  | 1242     | 402,450 |  1572.1    | 2485   | 12.52    | 156x   |
| 4 线程 2KB × 25万/线程    |  4  | 1,000,000 | 2048  | 3577     | 279,568 |   546.0    | 3577   | 24.78    |  79x   |
| 8 线程 2KB × 12.5万/线程  |  8  | 1,000,000 | 2048  | 3672     | 272,321 |   531.9    | 3672   | 25.98    |  75x   |

说明：
- `raw` = 日志条数 × 单条大小（压缩/加密前）
- `disk` = 实际写盘字节（Zstd 压缩 + AES 加密后）
- 压缩比 = raw / disk；AES 会带来少量膨胀，实际压缩增益由 Zstd 贡献

结论：
- 单线程 2KB 场景稳定在 ~45 万 QPS / 880 MB/s，含压缩+加密+落盘
- 4KB 日志负载下压缩比跃升至 156x（模板化日志重复度高）
- 多线程吞吐暂未线性扩展，瓶颈在 `Log()` 全程持锁（压缩+加密串行化），详见下方设计改进计划

## 已修复的并发 Bug（Zstd ResetStream 竞态）

早期版本在多线程场景（4 / 8 线程）下 stderr 会周期性出现 `EffectiveSink::Log: compress failed`。

**根因定位：** `ZSTD_CStream` 本身在"单一 owner 串行调用"下是安全的，真正的问题是 `EffectiveSink::Log()` 中 `ResetStream()` 被放在了 mutex **外面**：

```cpp
// BUG: ResetStream 在锁外
if (master_cache_->Empty()) {
    compress_->ResetStream();    // ← 线程 B 在此重置
}
{
    std::lock_guard<std::mutex> lock(mutex_);
    compress_->Compress(...);    // ← 线程 A 正在压缩，状态被 B 清空 → 返回 0
}
```

线程 A 持锁压缩到一半，线程 B 观察到 `master_cache_` 空，无锁地调用 `ResetStream()`，直接把 ZSTD 内部流状态清掉，A 的 `Compress` 返回 0，日志丢失。

**修复：** 把 `Empty()` 检查和 `ResetStream()` 一起移进 mutex 保护域（提交 `fix(sink): move ResetStream into mutex`）。修复后 8 线程跑 100 万条日志，`compress failed` 计数为 **0**，压缩率也略有回升（流状态不再被破坏）。

**后续性能改进方向（非 bug，是设计演进）：**
- 当前 Log 路径全程在 mutex 下，压缩/加密被串行化，这是多线程无法线性扩展的根因
- 下一步：把压缩/加密搬到 per-thread buffer，仅在入 mmap cache 时加锁（最小化临界区）
- 或引入 lock-free SPSC 环形队列，彻底消除锁

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
