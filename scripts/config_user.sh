#!/usr/bin/env bash

set -exuo pipefail

: "${USERNAME:?Need to set USERNAME non-empty}"
: "${PASSWORD:?Need to set PASSWORD non-empty}"
: "${GPG_PUB:?Need to set GPG_PUB non-empty}"
: "${GPG_PRIV:?Need to set GPG_PRIV non-empty}"
: "${ID_RSA_PUB:?Need to set GPG_PRIV non-empty}"
: "${ID_RSA:?Need to set ID_RSA non-empty}"
: "${GITHUB_ACCESS_TOKEN:?Need to set GITHUB_ACCESS_TOKEN non-empty}"

HOME=/home/$USERNAME

adduser --disabled-password --gecos "" $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
usermod -aG sudo $USERNAME

# ssh
mkdir -p $HOME/.ssh
echo $ID_RSA_PUB | base64 -d > $HOME/.ssh/id_rsa.pub
echo $ID_RSA     | base64 -d > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

# gpg
echo "$GPG_PUB" | base64 -d > pub
echo "$GPG_PRIV" | base64 -d > priv
gpg --import --batch pub
gpg --import --batch priv
rm pub priv

# git access
echo "https://$USERNAME:$GITHUB_ACCESS_TOKEN@github.com" > $HOME/.git-credentials
