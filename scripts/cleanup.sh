#!/usr/bin/env bash

: "${USERNAME:?Need to set USERNAME non-empty}"

HOME=/home/$USERNAME

# apt cache
sudo apt-get clean

# go build cache
rm -rf $HOME/.cache/go-build
