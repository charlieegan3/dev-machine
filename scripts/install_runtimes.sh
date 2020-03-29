#!/usr/bin/env bash

set -exo pipefail

curl -LO https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz && \
  tar -C /usr/local -xzf go1.14.1.linux-amd64.tar.gz && \
  rm go1.14.1.linux-amd64.tar.gz

gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
\curl -sSL https://get.rvm.io | bash -s stable --ruby --gems=bundler,nokogiri,pry
