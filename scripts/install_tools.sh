#!/usr/bin/env bash

set -exo pipefail

apt-get update
apt-get install -y silversearcher-ag tmux direnv jq tree mosh git make curl gpg \
  software-properties-common unzip vim python3-pip apt-transport-https ca-certificates \
  build-essential

curl -o fasd.zip -L https://github.com/clvv/fasd/zipball/1.0.1 && \
  unzip fasd.zip && \
  cd clvv-fasd-4822024 && \
  make install && \
  cd .. && \
  rm -rf clvv-fasd-4822024 fasd.zip

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb && \
  dpkg -i ripgrep_0.10.0_amd64.deb && \
  rm ripgrep_0.10.0_amd64.deb
