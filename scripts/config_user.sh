#!/usr/bin/env bash

set -exuo pipefail

: "${PASSWORD:?Need to set PASSWORD non-empty}"
: "${USERNAME:?Need to set USERNAME non-empty}"

HOME=/home/$USERNAME

adduser --disabled-password --gecos "" $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
usermod -aG sudo $USERNAME
touch ~/.sudo_as_admin_successful # hide sudo login hint
mkdir -p /home/$USERNAME/.ssh
cat /etc/id_rsa.pub >> /home/$USERNAME/.ssh/authorized_keys
