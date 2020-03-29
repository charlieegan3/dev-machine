#!/usr/bin/env bash

set -exo pipefail

apt-get update
apt-get install -y silversearcher-ag tmux direnv jq tree mosh git make curl gpg gnupg2 \
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

curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
chmod +x kubectx kubens
mv kubectx kubens /usr/local/bin/

curl -LO https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip && \
unzip *.zip && \
sudo mv packer /usr/local/bin/packer
rm *.zip
