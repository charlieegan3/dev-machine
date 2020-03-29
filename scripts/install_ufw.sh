#!/usr/bin/env bash

set -exo pipefail

ufw default deny incoming
ufw default allow outgoing

ufw allow ssh

ufw allow 60000:61000/udp # mosh
ufw allow 3000:3100/tcp # web
ufw allow 8000:8100/tcp # web

ufw enable
