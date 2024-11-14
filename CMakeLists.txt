cmake_minimum_required(VERSION 3.20)

set(PROJECT_NAME "logger")

project(${PROJECT_NAME} VERSION 1.1.1.1)

add_definitions(-DFMT_HEADER_ONLY=1)
add_definitions(-DENABLE_LOG=1)

set(INCDIRS . ${CMAKE_BINARY_DIR} logger logger/third_party/protobuf logger/third_party/spdlog/include)
include_directories(${INCDIRS})

if(MSVC)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /MP")
    set(LIBS ${LIBS} Kernel32)
    add_compile_options(/source-charset:utf-8 /execution-charset:utf-8)

    # generate pdb file
    set(CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE} /Zi")
    set(CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE} /Zi")
    set(CMAKE_SHARED_LINKER_FLAGS_RELEASE
        "${CMAKE_EXE_LINKER_FLAGS_RELEASE} /DEBUG /OPT:REF /OPT:ICF")

    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} /std:c++17")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} /std:c11")
else()
    set(LIBS ${LIBS} pthread)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++17 -fPIC")
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -std=c11 -fPIC")
endif()

message(STATUS "CMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE}")
message(STATUS "CMAKE_SYSTEM_NAME=${CMAKE_SYSTEM_NAME}")

if("${CMAKE_BUILD_TYPE}" STREQUAL "Debug")
    add_definitions(-DDEBUG)
else()
    add_definitions(-DNDEBUG)
endif()

add_subdirectory(logger)
add_subdirectory(example)
add_subdirectory(decode)
