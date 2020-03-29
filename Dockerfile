FROM ubuntu:18.04

ENV USERNAME=charlieegan3
ENV HOME=/home/$USERNAME

# Install latest configuration
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim && \
      vim +PlugInstall +qall
RUN export PATH=$PATH:/usr/local/go/bin && export GOPATH=$HOME/Code/go && \
     vim main.go +GoInstallBinaries +qall && \
     go get -u github.com/visualfc/gocode
RUN pip3 install --upgrade neovim
