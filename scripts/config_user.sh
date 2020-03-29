#!/usr/bin/env bash

HOME=/home/$USERNAME

adduser --disabled-password --gecos \"\" $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
usermod -aG sudo $USERNAME

# ssh
mkdir -p $HOME/.ssh
echo $ID_RSA_PUB | base64 -d > $HOME/.ssh/id_rsa.pub
echo $ID_RSA     | base64 -d > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

# gpg
echo $GPG_PUB | base64 -d > pub
echo $GPG_PRIV | base64 -d > priv
gpg --import --batch pub
gpg --import --batch priv
rm pub priv

# git access
echo "https://$USERNAME:$GITHUB_TOKEN@github.com" > $HOME/.git-credentials
