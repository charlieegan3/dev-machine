#!/usr/bin/env bash

set -exo pipefail

: "${USERNAME:?Need to set USERNAME non-empty}"

curl -LO https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.14.1.linux-amd64.tar.gz && \
  rm go1.14.1.linux-amd64.tar.gz

# install other editor requiremnts
curl -sSL https://rvm.io/mpapis.asc | gpg --import -
curl -sSL https://rvm.io/pkuczynski.asc | gpg --import -
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=bundler,nokogiri,pry
chown -R $USERNAME /usr/local/rvm
