#!/usr/bin/env bash

set -exo pipefail

: "${USERNAME:?Need to set USERNAME non-empty}"

# setup dotfiles
cd /home/$USERNAME
find /tmp/dotfiles -maxdepth 1 -mindepth 1 -exec mv {} . \;
rm -r /tmp/dotfiles
ls -al
chown -R $USERNAME:$USERNAME /home/$USERNAME

# Install vim requiremnts
sudo -i -u $USERNAME bash << EOF
set -exo pipefail

# install vim-plug
curl -fLo /home/$USERNAME/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# install go toolchain
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/Code/go
vim main.go +GoInstallBinaries +qall # main.go to load the plugin
EOF

# install other editor requiremnts
sudo -i -u $USERNAME bash << EOF
set -exo pipefail

go get -u github.com/visualfc/gocode
pip3 install --upgrade neovim
EOF
