#!/bin/bash

set -x
set -e

DEBIAN_FRONTEND=noninteractive

# remove unwanted software
sudo apt-get remove -y --purge aisleriot cheese dconf-editor gnome-calculator gnome-calendar \
  gnome-contacts gnome-documents gnome-games gnome-getting-started-docs \
  gnome-gettings-started-docs gnome-mahjongg gnome-maps gnome-mines \
  gnome-music gnome-orca gnome-photos gnome-sudoku gnome-user-guide \
  gnome-user-guide gnome-weather gnome-weather libreoffice* \
  rhythmbox* simple-scan totem || true
sudo apt-get clean
sudo apt-get autoremove

# install wanted software
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates software-properties-common
sudo apt-get install -y curl firefox git neovim rxvt-unicode silversearcher-ag tree vim

# configure dotfiles
if ! [ -d .git ]; then
  git init .
  git remote add -t \* -f origin https://github.com/charlieegan3/dotfiles.git
  git fetch origin
  git reset --hard origin/master
fi

# configure nvim
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall!
ln -sf .config/nvim/init.vim .vim_config

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
  "deb [arch=amd64] https://download.docker.com/linux/ubuntu yakkety stable \
  $(lsb_release -cs) \
  stable"
sudo apt-get update
sudo apt-get -y install docker-ce
sudo usermod -aG docker $USER

# install heroku tooling
heroku --version || curl https://toolbelt.heroku.com/install-ubuntu.sh | sh

# install toolchains
rvm || \curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=bundler,rails,nokogiri
go || sudo apt-get install -y golang-go
cargo || curl -sSf https://static.rust-lang.org/rustup.sh | sh

# gnome settings
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
curl https://raw.githubusercontent.com/chriskempson/base16-gnome-terminal/master/base16-londontube.light.sh | bash
