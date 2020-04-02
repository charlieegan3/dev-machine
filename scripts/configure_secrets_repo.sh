#!/usr/bin/env bash

set -exo pipefail

: "${USERNAME:?Need to set USERNAME non-empty}"

export REPO_PATH=/home/$USERNAME/.password-store

sudo -i -u $USERNAME bash << EOF
git clone https://github.com/charlieegan3/secrets $REPO_PATH
EOF
