#!/bin/bash

set -x
set -e

cd $HOME

# gpg
mkdir -p gpg_keys

gsutil cp gs://charlieegan3-dev-instance/gpg/* gpg_keys/

for f in gpg_keys/*
do
  gpg --import "$f"
done

rm -rf gpg_keys

# ssh
gsutil cp gs://charlieegan3-dev-instance/ssh/* /home/charlieegan3/.ssh/
