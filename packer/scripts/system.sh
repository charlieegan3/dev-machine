#!/bin/bash

set -x
set -e

# configure firewall
ufw default deny
ufw allow ssh
echo y | ufw enable
