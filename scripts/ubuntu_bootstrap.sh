#!/bin/bash

set -x
set -e

# dist upgrade
read -p "Run dist upgrade? y/n" -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  sudo apt-get dist-upgrade
fi

# install gnome
read -p "Install GNOME? y/n" -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  sudo add-apt-repository ppa:gnome3-team/gnome3-staging
  sudo add-apt-repository ppa:gnome3-team/gnome3
  sudo apt update
  sudo apt install gnome gnome-shell
fi

# remove unwanted software
read -p "Remove packages? y/n" -r
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
    sudo apt-get remove -y --purge "$package" || true
  done

  sudo apt-get clean
  sudo apt-get autoremove
fi

read -p "Install packages? y/n" -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  wget -O - https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt-get update

  wantedPackages=(apt-transport-https direnv ca-certificates \
    curl firefox gconf2 git silversearcher-ag \
    redshift software-properties-common tree \
    python-dev python3-dev python3-pip vim-gnome google-cloud-sdk jq \
    libvirt-bin libvirt-dev virtinst openvpn \
    compizconfig-settings-manager gnome-tweaks xsel ubuntu-restricted-extras \
	vagrant vlc browser-plugin-vlc libmagick++-dev)

  sudo apt-get update >> /dev/null
  for package in "${wantedPackages[@]}"
  do
    sudo apt-get install -y "$package"
  done
fi

read -p "Install snaps? y/n" -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
  snaps=(chromium heroku go spotify aws-cli skype doctl)

  for snap in "${snaps[@]}"
  do
    sudo snap install --classic "$snap"
  done
fi

read -p "Install vagrant? y/n" -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
	sudo apt-get install vagrant qemu libvirt-bin ebtables dnsmasq
	sudo apt-get install libxslt-dev libxml2-dev libvirt-dev zlib1g-dev ruby-dev
	vagrant plugin install vagrant-libvirt
fi

rvmStable="https://raw.githubusercontent.com/wayneeseguin/rvm/stable/binscripts/rvm-installer"
! [[ -e ~/.rvm ]] && command curl -sSL https://rvm.io/mpapis.asc | gpg2 --import - && \curl -sSL $rvmStable | bash -s stable --ruby --gems=bundler
# clear junk added to bashrc
[[ -e ~/.git ]] && git checkout .bashrc

! [[ -e /usr/bin/node ]] && curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash - && sudo apt-get install -y nodejs

! [[ -e ~/.tfenv/bin/tfenv ]] && git clone https://github.com/kamatama41/tfenv.git ~/.tfenv \
  && ~/.tfenv/bin/tfenv install latest || true

! [[ -e ~/Code/go/bin/vault ]] && go get -u github.com/hashicorp/vault

! [[ -e /usr/local/bin/packer ]] && curl -o /tmp/packer.zip https://releases.hashicorp.com/packer/1.2.1/packer_1.2.1_linux_amd64.zip && \
  unzip /tmp/packer.zip && \
  sudo mv packer /usr/local/bin

if ! [[ -e /snap/bin/docker ]]; then
  sudo snap install docker
  sudo snap connect docker:home
  sudo addgroup --system docker
  sudo adduser $USER docker
  newgrp docker
  sudo chmod 666 /var/run/docker.sock
  sudo snap disable docker
  sudo snap enable docker
fi

if ! [[ -e /usr/local/bin/with ]]; then
  sudo curl -s https://raw.githubusercontent.com/mchav/with/master/with -o /usr/local/bin/with
  sudo chmod +x /usr/local/bin/with
fi


if ! [[ -e /usr/local/bin/docker-compose ]]; then
  sudo curl -L https://github.com/docker/compose/releases/download/1.21.2/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
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

if ! [[ -e /usr/local/bin/tmux ]]; then
  sudo apt-get install -y libncurses5-dev libncursesw5-dev libevent-dev
  curl -L https://github.com/tmux/tmux/releases/download/2.5/tmux-2.5.tar.gz > /tmp/tmux.tar.gz
  sudo apt-get install libevent-dev
  tar xf /tmp/tmux.tar.gz
  cd tmux-2.5
  ./configure && make
  sudo make install
  cd ..
  rm -rf tmux-2.5
fi

if ! [[ -e /usr/local/bin/ngrok ]]; then
  curl https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o ngrok.zip
  unzip ngrok.zip
  sudo mv ngrok /usr/local/bin/ngrok
  rm ngrok.zip
fi

if ! [[ -e /usr/local/bin/bat ]]; then
  curl -L -o bat.tar.gz https://github.com/sharkdp/bat/releases/download/v0.2.3/bat-v0.2.3-x86_64-unknown-linux-gnu.tar.gz
  tar -xzf bat.tar.gz
  sudo mv bat-v0.2.3-x86_64-unknown-linux-gnu/bat /usr/local/bin
  rm -r bat-v0.2.3-x86_64-unknown-linux-gnu bat.tar.gz
fi

if ! [[ -e /usr/local/bin/hyper ]]; then
  curl -o hyper.tar.gz https://hyper-install.s3.amazonaws.com/hyper-linux-x86_64.tar.gz
  tar xzf hyper.tar.gz
  sudo mv hyper /usr/local/bin/hyper
  rm hyper.tar.gz
fi

if ! [[ -e /usr/local/bin/hugo ]]; then
  curl -o hugo.tar.gz -L https://github.com/gohugoio/hugo/releases/download/v0.40.2/hugo_0.40.2_Linux-64bit.tar.gz
  tar xzf hugo.tar.gz
  sudo mv hugo /usr/local/bin/hugo
  rm hugo.tar.gz
fi

if ! [[ -e /usr/local/bin/fasd ]]; then
  curl -o fasd.zip -L https://github.com/clvv/fasd/zipball/1.0.1
  unzip fasd.zip
  cd clvv-fasd-4822024
  sudo make install
  cd ..
  rm -rf clvv-fasd-4822024 fasd.zip
fi

if ! [[ -e /usr/local/bin/kubectx ]]; then
  curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
  curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
  chmod +x kubectx kubens
  sudo mv kubectx kubens /usr/local/bin/
fi

if ! [[ -e /usr/local/bin/hstr ]]; then
  git clone https://github.com/dvorka/hstr.git
  cd hstr
  cd ./build/tarball && ./tarball-automake.sh && cd ../..
  ./configure
  make
  sudo make install
fi

# configure dotfiles
if ! [ -e ~/.git ]; then
  git init .
  git remote add -t \* -f origin https://github.com/charlieegan3/dotfiles.git
  git fetch origin
  git reset --hard origin/master
fi

source ~/.bashrc

# configure vim
if ! [ -e ~/.vim/autoload/plug.vim ]; then
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
          https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  vim +PlugInstall +qall
  vim +GoInstallBinaries +qall
  go get -u gopkg.in/alecthomas/gometalinter.v2
  gometalinter --install
  curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
  pip3 install --upgrade neovim
fi

# config gnome
gsettings set org.gnome.desktop.background show-desktop-icons true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.sound event-sounds false
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.desktop.wm.preferences auto-raise true
gsettings set org.gnome.desktop.wm.preferences focus-mode click
gsettings set org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Alt>Enter']"
gsettings set org.gnome.desktop.wm.keybindings close "['<Alt>Q']"
gsettings set org.gnome.settings-daemon.plugins.media-keys screensaver '<Alt>l'
gsettings set org.gnome.settings-daemon.plugins.media-keys area-screenshot '<Shift><Alt>dollar'
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '<Shift><Alt>sterling'
gsettings set org.gnome.desktop.background picture-uri ~/.assets/aerial.jpg

if ! [ -e ~/.assets/theme-installed ]; then
  bash ~/.assets/base16-tube.dark.sh
  touch ~/.assets/theme-installed
  echo "Restart terminal to get new profile"
fi
