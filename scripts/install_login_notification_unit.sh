#!/usr/bin/env bash

set -exo pipefail

: "${PUSHOVER_TOKEN:?Need to set PUSHOVER_TOKEN non-empty}"
: "${PUSHOVER_USER:?Need to set PUSHOVER_USER non-empty}"

cat << EOF > /etc/systemd/system/set-sshrc.service
[Unit]
Description=Set SSH rc Unit
After=systemd-user-sessions.service

[Service]
Type=oneshot
ExecStart=/etc/set-sshrc.sh

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 /etc/systemd/system/set-sshrc.service
systemctl enable set-sshrc

# this is being set in a oneshot unit as it seems to block
# packer from continuing to later steps on the instance
cat << EOF > /etc/set-sshrc.sh
#!/usr/bin/env bash

cat << EOFF > /etc/ssh/sshrc
curl -X POST https://api.pushover.net/1/messages.json \
  -d message="login event" \
  -d token="$PUSHOVER_TOKEN" \
  -d user="$PUSHOVER_USER"
EOFF
EOF

chmod +x /etc/set-sshrc.sh
