# syntax=docker/dockerfile:1
FROM ubuntu:22.04

USER root
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    curl \
    g++ \
    cmake \
    zip \
    python3-pip \
    doxygen \
    graphviz \
    && apt-get clean

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && apt-get install -y nodejs

RUN useradd -ms /bin/bash developer
RUN adduser developer sudo
USER developer
WORKDIR /home/developer

ENV PATH="${PATH}:/home/developer/.local/bin"
RUN pip3 install --user conan
RUN conan profile detect --force

RUN mkdir -p /tmp/toolchain
RUN echo "\
[requires]\n\
spdlog/1.11.0\n\
\n\
[generators]\n\
CMakeDeps\n\
CMakeToolchain\n\
" >> /tmp/toolchain/conanfile.txt
RUN cd /tmp/toolchain && \
    conan profile detect --force && \
    conan install . --output-folder=./ --build=missing

ENV CMAKE_TOOLCHAIN_FILE="/tmp/toolchain/conan_toolchain.cmake"

ENV PATH="${PATH}:/tmp/build/"

