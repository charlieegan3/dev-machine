#!/bin/bash

set -x
set -e

cd $HOME

export DEBIAN_FRONTEND=noninteractive

wantedPackages=(
  apt-transport-https
  build-essential
  ca-certificates
  curl
  direnv
  git
  gnupg-agent
  libcurl4-gnutls-dev
  silversearcher-ag
  software-properties-common
  tree
  vim-gnome
)

apt-get update -y
apt-get upgrade -y

for package in "${wantedPackages[@]}"
do
  apt-get install -y "$package"
done
