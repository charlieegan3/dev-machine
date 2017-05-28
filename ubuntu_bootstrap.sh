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
sudo apt-get install -y software-properties-common
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
