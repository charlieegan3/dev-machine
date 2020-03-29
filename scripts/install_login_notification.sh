#!/usr/bin/env bash

: "${PUSHOVER_TOKEN:?Need to set PUSHOVER_TOKEN non-empty}"
: "${PUSHOVER_USER:?Need to set PUSHOVER_USER non-empty}"

message='Login at $(date)'

cat << EOF > /home/$USERNAME/.ssh/rc
curl -X POST https://api.pushover.net/1/messages.json \
  -d message="$message" \
  -d token="$PUSHOVER_TOKEN" \
  -d user="$PUSHOVER_USER"
EOF
