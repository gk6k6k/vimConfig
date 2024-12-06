# syntax=docker/dockerfile:1
ARG IMAGE_NAME
FROM $IMAGE_NAME

#USER root
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    unzip \
    curl \
    git \
    ripgrep \
    python3-pip \
    python3-venv \
    && apt-get clean

RUN mkdir /tmp/nvim && \
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz && \
    tar -C /usr/local -xzf nvim-linux64.tar.gz
#ADD https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz /usr/local/

#USER developer
ENV PATH="${PATH}:/usr/local/nvim-linux64/bin"

RUN python3 -m pip install --user --upgrade pynvim
#RUN npm install -g neovim
RUN mkdir -p /root/.config/nvim/
COPY init.lua /root/.config/nvim/init.lua
RUN nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
RUN nvim --headless -c 'MasonInstall clangd' -c 'quitall'

