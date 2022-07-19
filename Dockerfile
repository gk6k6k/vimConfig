ARG IMAGE_NAME
FROM $IMAGE_NAME

USER root
  RUN apt-get update && apt-get install -y \
     wget \
     ctags \
     curl

  RUN cd /tmp/ && \
      wget https://github.com/neovim/neovim/releases/download/v0.7.2/nvim-linux64.tar.gz && \
      tar -zxvf nvim-linux64.tar.gz && \
      echo ""

USER developer
  WORKDIR /home/developer
  SHELL ["/bin/bash", "-c"]
  RUN echo "alias genTags='ctags --recurse=yes --exclude=.git --exclude=BUILD --exclude=.svn --exclude=vendor/* --exclude=node_modules/* --exclude=db/* --exclude=log/*'" >> /home/developer/.bashrc
  RUN echo "alias nvim='/tmp/nvim-linux64/bin/nvim'" >> /home/developer/.bashrc
  RUN mkdir -p /home/developer/.config/nvim/
  COPY init.vim /home/developer/.config/nvim/
  RUN curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  RUN /tmp/nvim-linux64/bin/nvim -c'PlugInstall --sync' +qa
