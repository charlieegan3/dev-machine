#!/usr/bin/env bash

set -exuo pipefail

: "${B64_GPG_PRIV:?Need to set B64_GPG_PRIV non-empty}"
: "${B64_GPG_PUB:?Need to set B64_GPG_PUB non-empty}"
: "${B64_ID_RSA:?Need to set B64_ID_RSA non-empty}"
: "${B64_ID_RSA_PUB:?Need to set B64_ID_RSA_PUB non-empty}"
: "${GITHUB_ACCESS_TOKEN:?Need to set GITHUB_ACCESS_TOKEN non-empty}"
: "${PASSWORD:?Need to set PASSWORD non-empty}"
: "${USERNAME:?Need to set USERNAME non-empty}"

HOME=/home/$USERNAME

adduser --disabled-password --gecos "" $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
usermod -aG sudo $USERNAME

# ssh
mkdir -p $HOME/.ssh
echo $B64_ID_RSA_PUB | base64 -d > $HOME/.ssh/id_rsa.pub
echo $B64_ID_RSA     | base64 -d > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa

cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys

# gpg
echo "$B64_GPG_PUB" | base64 -d > pub
echo "$B64_GPG_PRIV" | base64 -d > priv
gpg --import --batch pub
gpg --import --batch priv
rm pub priv

# git access
echo "https://$USERNAME:$GITHUB_ACCESS_TOKEN@github.com" > $HOME/.git-credentials
