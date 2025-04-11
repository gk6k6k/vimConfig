# syntax=docker/dockerfile:1
FROM ubuntu:22.04

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    g++ \
    cmake \
    python3-pip \
    && apt-get clean

ENV PATH="${PATH}:/root/.local/bin"
RUN pip3 install --user conan
RUN conan profile detect --force

RUN echo "\
[requires]\n\
spdlog/1.10.0\n\
[generators]\n\
CMakeDeps\n\
CMakeToolchain\n\
[layout]\n\
cmake_layout\n\
\n\
" >> /root/conanfile.txt

RUN conan install /root/conanfile.txt --output-folder=/root/toolchain --build=missing
ENV CMAKE_TOOLCHAIN_FILE="/root/toolchain/build/Release/generators/conan_toolchain.cmake"
RUN echo "cmake -S . -B /tmp/build" >> /root/.bash_history
RUN echo "cmake --build /tmp/build/ -j && echo \"\" && app" >> /root/.bash_history
ENV PATH="${PATH}:/tmp/build"


