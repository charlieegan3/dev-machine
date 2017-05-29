#!/bin/bash

set -x
set -e

DEBIAN_FRONTEND=noninteractive

# remove unwanted software
sudo apt-get remove -y --purge aisleriot cheese dconf-editor gnome-calculator gnome-calendar \
  gnome-contacts gnome-documents gnome-games gnome-gettings-started-docs \
  gnome-mahjongg gnome-maps gnome-mines gnome-music gnome-orca gnome-photos \
  gnome-sudoku gnome-user-guide gnome-user-guide gnome-weather gnome-weather \
  libreoffice* rhythmbox* simple-scan totem || true
sudo apt-get clean
sudo apt-get autoremove

# install wanted software
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates software-properties-common
sudo apt-get install -y curl firefox git neovim silversearcher-ag tree vim

# install binaries
! [[ -e /usr/local/bin/terraform ]] && curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.9.6/terraform_0.9.6_linux_amd64.zip && \
  unzip /tmp/terraform.zip && \
  sudo mv terraform /usr/local/bin
! [[ -e /usr/local/bin/packer ]] && curl -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip && \
  unzip /tmp/packer.zip && \
  sudo mv packer /usr/local/bin

# install docker
if ! [[ -e /usr/bin/docker ]]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu yakkety stable \
    $(lsb_release -cs) \
    stable"
  sudo apt-get update
  sudo apt-get -y install docker-ce
  sudo usermod -aG docker $USER
fi

# install toolchains
! [[ -e ~/.rvm ]] && \curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=bundler,rails,nokogiri
! [[ -e /usr/bin/go ]] && sudo apt-get install -y golang-go
! [[ -e /usr/local/bin/cargo ]] && curl -sSf https://static.rust-lang.org/rustup.sh | sh

# install heroku tooling
! [[ -e /usr/local/heroku ]] && curl https://toolbelt.heroku.com/install-ubuntu.sh | sh && git checkout .bashrc

# configure dotfiles
if ! [ -e ~/.git ]; then
  git init .
  git remote add -t \* -f origin https://github.com/charlieegan3/dotfiles.git
  git fetch origin
  git reset --hard origin/master
fi

# configure neovim
if ! [ -e ~/.config/nvim/autoload/plug.vim ]; then
  curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  nvim +PlugInstall +qall
  ln -sf .config/nvim/init.vim .vim_config
fi

# gnome settings
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.sound event-sounds false
if ! [ -e ~/resources/theme-installed ]; then
  # new terminal profile required
  bash ~/resources/base16-londontube.light.sh
  touch ~/resources/theme-installed
fi
