#!/usr/bin/env bash

set -exuo pipefail

: "${PASSWORD:?Need to set PASSWORD non-empty}"
: "${USERNAME:?Need to set USERNAME non-empty}"

HOME=/home/$USERNAME

# sometimes user appears present when not, https://askubuntu.com/questions/104851/adduser-says-user-exists-when-the-user-does-not-exist
userdel -r $USERNAME || true
adduser --disabled-password --gecos "" $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
usermod -aG sudo $USERNAME
touch ~/.sudo_as_admin_successful # hide sudo login hint
mkdir -p /home/$USERNAME/.ssh
