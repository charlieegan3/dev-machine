#!/usr/bin/env bash

# script pasted into userdata field, set the variables below.

set -exuo pipefail

: "${B64_GPG_PRIV:?Need to set B64_GPG_PRIV non-empty}"
: "${B64_GPG_PUB:?Need to set B64_GPG_PUB non-empty}"
: "${B64_ID_RSA:?Need to set B64_ID_RSA non-empty}"
: "${B64_ID_RSA_PUB:?Need to set B64_ID_RSA_PUB non-empty}"
: "${HETZNER_TOKEN:?Need to set HETZNER_TOKEN non-empty}"
: "${GITHUB_ACCESS_TOKEN:?Need to set GITHUB_ACCESS_TOKEN non-empty}"
: "${PASSWORD:?Need to set PASSWORD non-empty}"
: "${PUSHOVER_TOKEN:?Need to set PUSHOVER_TOKEN non-empty}"
: "${PUSHOVER_USER:?Need to set PUSHOVER_USER non-empty}"
: "${USERNAME:?Need to set USERNAME non-empty}"

# -----------------------------------------------------------------------------
# replace dummy password
# -----------------------------------------------------------------------------
echo $USERNAME:$PASSWORD | chpasswd

# -----------------------------------------------------------------------------
# configure ssh access
# -----------------------------------------------------------------------------
HOME=/home/$USERNAME
mkdir -p $HOME/.ssh
echo $B64_ID_RSA_PUB | base64 -d > $HOME/.ssh/id_rsa.pub
echo $B64_ID_RSA     | base64 -d > $HOME/.ssh/id_rsa
chmod 600 $HOME/.ssh/id_rsa
cat $HOME/.ssh/id_rsa.pub > $HOME/.ssh/authorized_keys
chown -R $USERNAME $HOME/.ssh

# -----------------------------------------------------------------------------
# configure gpg keys
# -----------------------------------------------------------------------------
cd $HOME
echo "$B64_GPG_PUB" | base64 -d > pub
echo "$B64_GPG_PRIV" | base64 -d > priv
sudo -i -u $USERNAME bash << EOF
set -exuo pipefail
gpg2 --import --batch pub # gpg2 needed for batch, only used here
gpg2 --import --batch priv # gpg2 needed for batch, only used here
EOF
rm pub priv

# -----------------------------------------------------------------------------
# configure git access
# -----------------------------------------------------------------------------
echo "https://$USERNAME:$GITHUB_ACCESS_TOKEN@github.com" > $HOME/.git-credentials

# -----------------------------------------------------------------------------
# configure dev-machine repo
# -----------------------------------------------------------------------------
export REPO_PATH=/home/$USERNAME/Code/dev-machine

[[ -d $REPO_PATH ]] || sudo -i -u $USERNAME bash << EOF
set -exuo pipefail
git clone https://github.com/charlieegan3/dev-machine $REPO_PATH

cd $REPO_PATH

cat << EOFF > .envrc
export B64_GPG_PRIV=$B64_GPG_PRIV
export B64_GPG_PUB=$B64_GPG_PUB
export B64_ID_RSA=$B64_ID_RSA
export B64_ID_RSA_PUB=$B64_ID_RSA_PUB
export HETZNER_TOKEN="$HETZNER_TOKEN"
export GITHUB_ACCESS_TOKEN="$GITHUB_ACCESS_TOKEN"
export PASSWORD="$PASSWORD"
export PUSHOVER_TOKEN="$PUSHOVER_TOKEN"
export PUSHOVER_USER="$PUSHOVER_USER"
EOFF

direnv allow
EOF

# -----------------------------------------------------------------------------
# configure login notifications
# -----------------------------------------------------------------------------
cat << EOF > /etc/ssh/sshrc
curl -X POST https://api.pushover.net/1/messages.json \
  -d message="login event" \
  -d token="$PUSHOVER_TOKEN" \
  -d user="$PUSHOVER_USER"
EOF

# -----------------------------------------------------------------------------
# install inactive notifications unit
# -----------------------------------------------------------------------------
cat << EOF > /etc/systemd/system/inactive-termination.service
[Unit]
Description=Inactive Termination Unit
After=systemd-user-sessions.service

[Service]
Type=simple
ExecStart=/etc/inactive-termination.sh
Environment=PUSHOVER_TOKEN=$PUSHOVER_TOKEN
Environment=PUSHOVER_USER=$PUSHOVER_USER
Restart=always

[Install]
WantedBy=multi-user.target
EOF

cat << 'EOF' > /etc/inactive-termination.sh
#!/usr/bin/env bash

set -exuo pipefail

: "${PUSHOVER_TOKEN:?Need to set PUSHOVER_TOKEN non-empty}"
: "${PUSHOVER_USER:?Need to set PUSHOVER_USER non-empty}"

last_count="1"
inactive_seconds=0
warning_sent=false
shutdown_started=false

function send_message {
  curl -X POST https://api.pushover.net/1/messages.json \
    -d message="$1" \
    -d token="$PUSHOVER_TOKEN" \
    -d user="$PUSHOVER_USER"
}

while true; do
  new_count="$(who | grep -v tmux | wc -l)"

  if [ "$new_count" == "0" ]; then
    (( inactive_seconds++ ))
  else
    inactive_seconds=0
    warning_sent=false
  fi

  if (( $inactive_seconds > 30 )); then
    if [ "$warning_sent" == "false" ]; then
      send_message "alarm"
      warning_sent=true
    fi
  fi

  if (( $inactive_seconds > 60 )); then
    if [ "$shutdown_started" == "false" ]; then
      send_message "shutdown"
      shutdown_started=true
    fi
  fi

  last_count="$new_count"
  sleep 1
done
EOF

sudo chmod 644 /etc/systemd/system/inactive-termination.service
chmod +x /etc/inactive-termination.sh
systemctl enable inactive-termination
systemctl start inactive-termination

# -----------------------------------------------------------------------------
# install history sync unit
# -----------------------------------------------------------------------------
REPO_PATH=/home/$USERNAME/Code/secrets-history

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

cat << EOF > /etc/history-sync.sh
#!/usr/bin/env bash

set -exuo pipefail

# continue to sync the files
while true; do
  make -C $REPO_PATH sync
  sleep 100
done
EOF

[[ -d $REPO_PATH ]] || sudo -i -u $USERNAME bash << EOF
set -exuo pipefail

git clone https://github.com/charlieegan3/secrets-history $REPO_PATH

# update to the latest repo data
make -C $REPO_PATH write
EOF

sudo chmod 644 /etc/systemd/system/history-sync.service
chmod +x /etc/history-sync.sh
systemctl enable history-sync
systemctl start history-sync

# -----------------------------------------------------------------------------
# configure secrets repo
# -----------------------------------------------------------------------------
REPO_PATH=/home/$USERNAME/.password-store
[[ -d $REPO_PATH ]] || sudo -i -u $USERNAME bash << EOF
set -exuo pipefail
git clone https://github.com/charlieegan3/secrets $REPO_PATH
cd $REPO_PATH
git-crypt unlock
EOF
