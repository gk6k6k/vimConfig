cmake_minimum_required(VERSION 3.9)

project(
  "CudaExample"
  VERSION 0.0.1
  LANGUAGES CXX CUDA)

find_package(CUDA REQUIRED)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_BUILD_TYPE Release)

add_executable("CudaExample" "source/main.cpp" "source/example.cu")

target_include_directories(CudaExample PUBLIC "include" ${CUDA_INCLUDE_DIRS})
target_link_libraries(CudaExample ${CUDA_LIBRARIES})
