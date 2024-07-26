# syntax=docker/dockerfile:1
FROM ubuntu:22.04

USER root
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    sudo \
    g++ \
    cmake \
    zip \
    && apt-get clean

