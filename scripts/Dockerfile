ARG IMAGE_NAME
FROM $IMAGE_NAME

RUN apt-get update && apt-get install -y \
    wget \
    curl \
    && apt-get clean

RUN cd /tmp/ && \
    wget https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.tar.gz && \
    tar -zxvf nvim-linux-x86_64.tar.gz && \
    echo ""

#RUN echo "export PATH=\$PATH:/tmp/go/bin" >> ~/.bashrc
#RUN echo "export GOPATH=/tmp/go" >> ~/.bashrc
#RUN go install github.com/jesseduffield/lazygit@latest


RUN mkdir -p ~/.config/nvim/autoload/
RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
ADD init.lua ~/.config/nvim/


#RUN mkdir -p /home/developer/.config/nvim/
#COPY $NVIM_INIT_PATH /home/developer/.config/nvim/
#RUN /tmp/nvim-linux64/bin/nvim -c'PlugInstall --sync' +qa
