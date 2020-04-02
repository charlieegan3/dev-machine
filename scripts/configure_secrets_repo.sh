#!/usr/bin/env bash

set -exo pipefail

export REPO_PATH=/home/$USERNAME/.password-store

sudo -i -u $USERNAME bash << EOF
git clone https://github.com/charlieegan3/secrets $REPO_PATH
EOF
