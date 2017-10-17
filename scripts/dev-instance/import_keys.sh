#!/bin/bash

set -x
set -e

curl https://github.com/charlieegan3.keys > .ssh/authorized_keys

mkdir -p gpg_keys

gsutil cp gs://charlieegan3-gpg-keys/* gpg_keys/

for f in gpg_keys/*
do
  gpg --import "$f"
done

rm -rf gpg_keys
