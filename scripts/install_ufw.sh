#!/usr/bin/env bash

set -exo pipefail

ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw allow 60000:61000/udp # mosh
ufw enable
