cmake_minimum_required(VERSION 3.9)

project(projectRunner)

set(CMAKE_BUILD_TYPE Release)

find_package(spdlog REQUIRED)

add_executable(projectRunner
    source/main.cpp)

target_link_libraries(
  projectRunner
  PUBLIC spdlog::spdlog)
