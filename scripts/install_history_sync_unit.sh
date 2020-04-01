#!/usr/bin/env bash

set -exo pipefail

: "${USERNAME:?Need to set USERNAME non-empty}"

export REPO_PATH=/home/$USERNAME/Code/secrets-history

cat << EOF > /etc/systemd/system/history-sync.service
[Unit]
Description=History Sync Unit
After=systemd-user-sessions.service

[Service]
Type=simple
ExecStart=/etc/history-sync.sh
Restart=Always
User=$USERNAME
EOF

sudo chmod 644 /etc/systemd/system/history-sync.service
systemctl enable history-sync

cat << EOF > /etc/history-sync.sh
#!/usr/bin/env bash

make -C $REPO_PATH sync
EOF

chmod +x /etc/history-sync.sh

sudo -i -u $USERNAME bash << EOF
git clone https://github.com/charlieegan3/secrets-history $REPO_PATH
EOF
