#!/usr/bin/env bash

set -exo pipefail

curl -LO https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.14.1.linux-amd64.tar.gz && \
  rm go1.14.1.linux-amd64.tar.gz
