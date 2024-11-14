include_guard(GLOBAL)

include_directories(. third_party/cryptopp_cmake third_party/protobuf third_party/fmt/include)

add_subdirectory(third_party/cryptopp_cmake)
add_subdirectory(third_party/protobuf)
add_subdirectory(third_party/zstd/build/cmake zstd)
add_subdirectory(third_party/zlib)

if(CMAKE_SYSTEM_NAME STREQUAL "Linux")
    set(MMAP_SRCS mmap/mmap_aux.cc mmap/mmap_linux.cc)
    set(UTIL_SRCS utils/sys_util_linux.cc utils/sys_util.cc utils/file_util.cc)
elseif(CMAKE_SYSTEM_NAME STREQUAL "Windows")
    set(MMAP_SRCS mmap/mmap_aux.cc mmap/mmap_win.cc)
    set(UTIL_SRCS utils/sys_util_win.cc utils/sys_util.cc utils/file_util.cc)
else()
    message(FATAL_ERROR "unsupported.")
endif()

set(FORMATTER_SRCS formatter/default_formatter.cc formatter/effective_formatter.cc)
set(SINK_SRCS sinks/console_sink.cc sinks/effective_sink.cc)
set(COMPRESS_SRCS compress/zlib_compress.cc compress/zstd_compress.cc)
set(CRYPT_SRCS crypt/aes_crypt.cc crypt/crypt.cc)
set(CONTEXT_SRCS context/context.cc context/executor.cc context/thread_pool.cc)

set(SRCS
    log_factory.cc
    log_handle.cc
    log_msg.cc
    ${CMAKE_BINARY_DIR}/effective_msg.pb.cc
    ${MMAP_SRCS}
    ${UTIL_SRCS}
    ${FORMATTER_SRCS}
    ${SINK_SRCS}
    ${COMPRESS_SRCS}
    ${CRYPT_SRCS}
    ${CONTEXT_SRCS}
)

message(STATUS "libs ${LIBS}")

add_library(logger STATIC ${SRCS})
target_link_libraries(logger PRIVATE ${LIBS} cryptopp protobuf libzstd_static zlib)
