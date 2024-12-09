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

RUN mkdir -p /tmp/toolchain
RUN echo "\
[requires]\n\
gtest/cci.20210126\n\
\n\
[generators]\n\
CMakeDeps\n\
CMakeToolchain\n\
\n\
" >> /tmp/toolchain/conanfile.txt

RUN cd /tmp/toolchain && \
    conan profile detect --force && \
    conan install . --output-folder=./ --build=missing
