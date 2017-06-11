#!/bin/bash

set -x
set -e

DEBIAN_FRONTEND=noninteractive

# remove unwanted software
read -p "Remove packages? y/n" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  unwantedPackages=(aisleriot cheese dconf-editor gnome-calculator gnome-calendar \
    gnome-contacts gnome-documents gnome-games gnome-gettings-started-docs \
    gnome-mahjongg gnome-maps gnome-mines gnome-music gnome-orca gnome-photos \
    gnome-sudoku gnome-user-guide gnome-user-guide gnome-weather gnome-weather \
    libreoffice* rhythmbox* simple-scan totem)

  for package in "${unwantedPackages[@]}"
  do
    sudo apt-get remove -y --purge $package || true
  done

  sudo apt-get clean
  sudo apt-get autoremove
fi

# install wanted software
read -p "Install packages? y/n" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  wantedPackages=(apt-transport-https ca-certificates chromium-browser curl \
  firefox git neovim silversearcher-ag software-properties-common tree vim)

  sudo apt-get update >> /dev/null
  for package in "${wantedPackages[@]}"
  do
    sudo apt-get install -y $package
  done
fi

# install things that don't come in boxes
! [[ -e ~/.rvm ]] && \curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=bundler,rails,nokogiri
! [[ -e /usr/bin/go ]] && sudo apt-get install -y golang-go
! [[ -e /usr/local/bin/cargo ]] && curl -sSf https://static.rust-lang.org/rustup.sh | sh
! [[ -e /usr/local/heroku ]] && curl https://toolbelt.heroku.com/install-ubuntu.sh | sh && git checkout .bashrc

! [[ -e /usr/local/bin/terraform ]] && curl -o /tmp/terraform.zip https://releases.hashicorp.com/terraform/0.9.6/terraform_0.9.6_linux_amd64.zip && \
  unzip /tmp/terraform.zip && \
  sudo mv terraform /usr/local/bin

! [[ -e /usr/local/bin/packer ]] && curl -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_linux_amd64.zip && \
  unzip /tmp/packer.zip && \
  sudo mv packer /usr/local/bin

if ! [[ -e /usr/bin/docker ]]; then
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu yakkety stable \
    $(lsb_release -cs) \
    stable"
  sudo apt-get update >> /dev/null
  sudo apt-get -y install docker-ce
  sudo usermod -aG docker $USER
fi

if ! [[ -e /usr/bin/spotify ]]; then
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886
  echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
  sudo apt-get update >> /dev/null
  sudo apt-get install -y spotify-client
fi

if ! [ -e ~/.local/bin/aws ]; then
  sudo apt-get install -y python-pip python-dev build-essential
  sudo pip install --upgrade pip
  pip install --upgrade --user awscli
fi

if ! [ -e ~/usr/bin/psql ]; then
  sudo apt-get install -y postgresql postgresql-contrib postgresql-client libpq-dev

  PG_HBA=$(sudo ls /etc/postgresql/*/main/pg_hba.conf | sort | tail -n 1)
  sudo sed -i.bak -e 's/peer\|md5/trust/g' $PG_HBA
  sudo /etc/init.d/postgresql restart

  sudo -u postgres createuser $(whoami) || true
  sudo -u postgres createdb $(whoami) || true
  psql -U postgres -c "ALTER USER $(whoami) WITH SUPERUSER;"
fi

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
  nvim +GoInstallBinaries +qall
  ln -sf .config/nvim/init.vim .vim_config
fi

# config gnome
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.sound event-sounds false
gsettings set org.gnome.desktop.wm.keybindings maximize "['<Alt>Up']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>Q']"
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Primary><Alt>Up']"
gsettings set org.gnome.desktop.wm.keybindings show-desktop "['<Alt>Escape']"
gsettings set org.gnome.desktop.wm.preferences auto-raise true
gsettings set org.gnome.desktop.wm.preferences focus-mode click
gsettings set org.gnome.mutter.keybindings toggle-tiled-left "['<Alt>Left']"
gsettings set org.gnome.mutter.keybindings toggle-tiled-right "['<Alt>Right']"
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot '<Shift><Alt>dollar'
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '<Shift><Alt>sterling'
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal '<Alt>Return'
gsettings set org.gnome.settings-daemon.plugins.media-keys www '<Shift><Alt>Return'
if ! [ -e ~/resources/theme-installed ]; then
  # new terminal profile required
  bash ~/resources/base16-londontube.light.sh
  touch ~/resources/theme-installed
fi
