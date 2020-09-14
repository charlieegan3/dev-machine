#!/usr/bin/env bash

# script pasted into userdata field, set the variables below.

set -exuo pipefail

: "${B64_GPG_PRIV:?Need to set B64_GPG_PRIV non-empty}"
: "${B64_GPG_PUB:?Need to set B64_GPG_PUB non-empty}"
: "${B64_ID_RSA:?Need to set B64_ID_RSA non-empty}"
: "${B64_ID_RSA_PUB:?Need to set B64_ID_RSA_PUB non-empty}"
: "${HCLOUD_TOKEN:?Need to set HCLOUD_TOKEN non-empty}"
: "${GITHUB_ACCESS_TOKEN:?Need to set GITHUB_ACCESS_TOKEN non-empty}"
: "${PASSWORD:?Need to set PASSWORD non-empty}"
: "${PUSHOVER_TOKEN:?Need to set PUSHOVER_TOKEN non-empty}"
: "${PUSHOVER_USER:?Need to set PUSHOVER_USER non-empty}"
: "${USERNAME:?Need to set USERNAME non-empty}"

# -----------------------------------------------------------------------------
# replace dummy password
# -----------------------------------------------------------------------------
echo $USERNAME:$PASSWORD | chpasswd

# -----------------------------------------------------------------------------
# configure ssh access
# -----------------------------------------------------------------------------
HOME=/home/$USERNAME
mkdir -p $HOME/.ssh
echo $B64_ID_RSA_PUB | base64 -d > $HOME/.ssh/id_rsa.pub
echo $B64_ID_RSA     | base64 -d > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa
cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys
chown -R $USERNAME $HOME/.ssh

# -----------------------------------------------------------------------------
# configure gpg keys
# -----------------------------------------------------------------------------
cd $HOME
echo "$B64_GPG_PUB" | base64 -d > pub
echo "$B64_GPG_PRIV" | base64 -d > priv
sudo -i -u $USERNAME bash << EOF
set -exuo pipefail
gpg2 --import --batch pub # gpg2 needed for batch, only used here
gpg2 --import --batch priv # gpg2 needed for batch, only used here
EOF
rm pub priv

# -----------------------------------------------------------------------------
# configure git access
# -----------------------------------------------------------------------------
echo "https://$USERNAME:$GITHUB_ACCESS_TOKEN@github.com" > $HOME/.git-credentials

# -----------------------------------------------------------------------------
# configure dev-machine repo
# -----------------------------------------------------------------------------
export REPO_PATH=/home/$USERNAME/Code/dev-machine

[[ -d $REPO_PATH ]] || sudo -i -u $USERNAME bash << EOF
set -exuo pipefail
git clone https://github.com/charlieegan3/dev-machine $REPO_PATH

cd $REPO_PATH

cat << EOFF > .envrc
export B64_GPG_PRIV=$B64_GPG_PRIV
export B64_GPG_PUB=$B64_GPG_PUB
export B64_ID_RSA=$B64_ID_RSA
export B64_ID_RSA_PUB=$B64_ID_RSA_PUB
export HCLOUD_TOKEN="$HCLOUD_TOKEN"
export GITHUB_ACCESS_TOKEN="$GITHUB_ACCESS_TOKEN"
export PASSWORD="$PASSWORD"
export PUSHOVER_TOKEN="$PUSHOVER_TOKEN"
export PUSHOVER_USER="$PUSHOVER_USER"
EOFF

direnv allow
EOF

# -----------------------------------------------------------------------------
# configure login notifications
# -----------------------------------------------------------------------------
cat << EOF > /etc/ssh/sshrc
curl -X POST https://api.pushover.net/1/messages.json \
  -d message="login event" \
  -d token="$PUSHOVER_TOKEN" \
  -d user="$PUSHOVER_USER" \
  --silent \
  >> /dev/null
EOF


# -----------------------------------------------------------------------------
# allow ssh on GCE
# -----------------------------------------------------------------------------
sudo ufw allow 22
