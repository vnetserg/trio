cmake_minimum_required(VERSION 3.5)

set(CMAKE_CXX_STANDARD 11)

add_subdirectory(abseil-cpp)
include_directories(abseil-cpp)

add_executable(cpp_absl_jemalloc main.cpp)

target_link_libraries(cpp_absl_jemalloc jemalloc absl::container absl::hash absl::hashtablez_sampler absl::raw_hash_set)
