#!/usr/bin/env bash

set -exo pipefail

: "${B64_GPG_PRIV:?Need to set B64_GPG_PRIV non-empty}"
: "${B64_GPG_PUB:?Need to set B64_GPG_PUB non-empty}"
: "${B64_ID_RSA:?Need to set B64_ID_RSA non-empty}"
: "${B64_ID_RSA_PUB:?Need to set B64_ID_RSA_PUB non-empty}"
: "${DIGITALOCEAN_API_TOKEN:?Need to set DIGITALOCEAN_API_TOKEN non-empty}"
: "${GITHUB_ACCESS_TOKEN:?Need to set GITHUB_ACCESS_TOKEN non-empty}"
: "${PASSWORD:?Need to set PASSWORD non-empty}"
: "${USERNAME:?Need to set USERNAME non-empty}"

export REPO_PATH=/home/$USERNAME/Code/dev-machine

sudo -i -u $USERNAME bash << EOF
git clone https://github.com/charlieegan3/dev-machine $REPO_PATH

cd $REPO_PATH

cat << EOFF > .envrc
export B64_GPG_PRIV="$B64_GPG_PRIV"
export B64_GPG_PUB="$B64_GPG_PUB"
export B64_ID_RSA="$B64_ID_RSA"
export B64_ID_RSA_PUB="$B64_ID_RSA_PUB"
export DIGITALOCEAN_API_TOKEN="$DIGITALOCEAN_API_TOKEN"
export GITHUB_ACCESS_TOKEN="$GITHUB_ACCESS_TOKEN"
export PASSWORD="$PASSWORD"
EOFF

direnv allow
EOF
