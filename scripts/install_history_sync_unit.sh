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
Restart=always
User=$USERNAME

[Install]
WantedBy=multi-user.target
EOF

sudo chmod 644 /etc/systemd/system/history-sync.service
systemctl enable history-sync

sudo -i -u $USERNAME bash << EOF
git clone https://github.com/charlieegan3/secrets-history $REPO_PATH

# update to the latest repo data
make -C $REPO_PATH write
EOF

cat << EOF > /etc/history-sync.sh
#!/usr/bin/env bash

# continue to sync the files
while true; do
  make -C $REPO_PATH sync
  sleep 100
done
EOF

chmod +x /etc/history-sync.sh
