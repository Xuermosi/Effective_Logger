cmake_minimum_required(VERSION 3.20)
project(decoder)

add_executable(decoder decode.cc decode_formatter.cc)
target_link_libraries(decoder logger)
