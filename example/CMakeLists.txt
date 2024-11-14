cmake_minimum_required(VERSION 3.16)
project(logger_example)

add_executable(logger_example logger_example.cc)
target_link_libraries(logger_example logger)

add_executable(macro_logger_example macro_logger_example.cc)
target_link_libraries(macro_logger_example logger)

add_executable(crypt_example crypt_example.cc)
target_link_libraries(crypt_example logger)

add_executable(zstd_example zstd_example.cc)
target_link_libraries(zstd_example logger)
