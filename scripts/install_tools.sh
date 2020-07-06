#!/usr/bin/env bash

set -exo pipefail

: "${USERNAME:?Need to set USERNAME non-empty}"

apt-get update
apt-get install -y silversearcher-ag tmux direnv jq tree mosh git make curl gpg gnupg2 \
  software-properties-common unzip vim python3-pip apt-transport-https ca-certificates \
  build-essential postgresql-client libpq5 libpq-dev git-crypt python3-setuptools \
  libmagick++-dev

# rg
curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb && \
  dpkg -i ripgrep_0.10.0_amd64.deb && \
  rm ripgrep_0.10.0_amd64.deb

# rclone
curl https://rclone.org/install.sh | sudo bash

# kubectl etc
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubens
curl -LO https://raw.githubusercontent.com/ahmetb/kubectx/master/kubectx
chmod +x kubectx kubens
mv kubectx kubens /usr/local/bin/

# helm
HELM_VERSION=3.1.2
curl -LO https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz
tar -zxvf helm-v${HELM_VERSION}-linux-amd64.tar.gz
mv linux-amd64/helm /usr/local/bin/helm
rm -r linux-amd64 helm-v${HELM_VERSION}-linux-amd64.tar.gz

# packer
curl -LO https://releases.hashicorp.com/packer/1.5.5/packer_1.5.5_linux_amd64.zip && \
unzip *.zip && \
sudo mv packer /usr/local/bin/packer
rm *.zip

# hugo
HUGO_VERSION=0.68.3
curl -o hugo.tar.gz -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_Linux-64bit.tar.gz
  tar xzf hugo.tar.gz
  sudo mv hugo /usr/local/bin/hugo
  rm hugo.tar.gz

# gcloud
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get update
sudo apt-get install -y google-cloud-sdk

# install jsonnet
git clone https://github.com/google/jsonnet
cd jsonnet/
make
sudo mv jsonnet /usr/local/bin/
sudo mv jsonnetfmt /usr/local/bin/
cd .. && rm -r jsonnet

# install vault
curl -LO https://releases.hashicorp.com/vault/1.4.0/vault_1.4.0_linux_amd64.zip
unzip vault*.zip
mv vault /usr/bin/vault
rm vault*.zip

# install go-based tools
sudo -i -u $USERNAME bash << EOF
set -exo pipefail

# install jsonnet bundler
go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb
# install gojsontoyaml
go get github.com/brancz/gojsontoyaml
# install hcloud cli
go get github.com/hetznercloud/cli/cmd/hcloud
EOF
