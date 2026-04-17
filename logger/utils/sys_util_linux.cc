

#include "utils/sys_util.h"

#include <unistd.h>
#ifdef __APPLE__
#include <pthread.h>
#else
#include <sys/syscall.h>
#endif

namespace logger {

size_t GetPageSize() {
  return getpagesize();
}

size_t GetProcessId() {
  return static_cast<size_t>(::getpid());
}

size_t GetThreadId() {
#ifdef __APPLE__
  uint64_t tid = 0;
  pthread_threadid_np(nullptr, &tid);
  return static_cast<size_t>(tid);
#else
  return static_cast<size_t>(::syscall(SYS_gettid));
#endif
}

void LocalTime(std::tm* tm, std::time_t* now) {
  localtime_r(now, tm);
}

}  // namespace logger
