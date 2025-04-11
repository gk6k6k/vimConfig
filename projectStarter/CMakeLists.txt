cmake_minimum_required(VERSION 3.10)

project("app" VERSION 0.0.1 LANGUAGES CXX)

set(CMAKE_BUILD_TYPE Release)
set(CMAKE_CXX_STANDARD 17)

find_package(spdlog)

set(SOURCES
    source/app.cpp
)

add_executable(app ${SOURCES})

target_link_libraries(app PRIVATE spdlog::spdlog)
