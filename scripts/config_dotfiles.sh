#!/usr/bin/env bash

set -exo pipefail

# setup dotfiles
cd /home/$USERNAME
find /tmp/dotfiles -maxdepth 1 -mindepth 1 -exec mv {} . \;
rm -r /tmp/dotfiles
ls -al
chown -R $USERNAME:$USERNAME /home/$USERNAME

sudo -i -u $USERNAME bash << EOF
# install vim-plug
curl -fLo /home/$USERNAME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# install go toolchain
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Code/go
vim main.go +GoInstallBinaries +qall # main.go to load the plugin
go get -u github.com/visualfc/gocode
pip3 install --upgrade neovim
EOF
