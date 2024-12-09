cmake_minimum_required(VERSION 3.9)

project("Stuff" VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)
set(CMAKE_BUILD_TYPE Release)

find_package(GTest REQUIRED)

add_executable(StuffTest)
target_sources(StuffTest PRIVATE bitView.cpp)
target_link_libraries(StuffTest GTest::gmock_main)


