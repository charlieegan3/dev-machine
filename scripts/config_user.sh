#!/usr/bin/env bash

adduser --disabled-password --gecos \"\" $USERNAME
echo $USERNAME:$PASSWORD | chpasswd
usermod -aG sudo $USERNAME
