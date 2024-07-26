# syntax=docker/dockerfile:1
FROM ubuntu:22.04

USER root
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    g++ \
    cmake \
    zip \
    python3-pip \
    && apt-get clean

ENV PATH="${PATH}:/root/.local/bin"
RUN pip3 install --user conan
RUN conan profile detect --force

