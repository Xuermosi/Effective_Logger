cmake_minimum_required(VERSION 3.16)
project(zlib)

set(INCDIRS . include)
include_directories(${INCDIRS})

set(ZLIB_SRCS
    src/adler32.c
    src/compress.c
    src/crc32.c
    src/deflate.c
    src/gzclose.c
    src/gzlib.c
    src/gzread.c
    src/gzwrite.c
    src/inflate.c
    src/infback.c
    src/inftrees.c
    src/inffast.c
    src/trees.c
    src/uncompr.c
    src/zutil.c)

add_library(zlib STATIC ${ZLIB_SRCS})
