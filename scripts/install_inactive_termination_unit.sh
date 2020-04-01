#!/usr/bin/env bash

: "${PUSHOVER_TOKEN:?Need to set PUSHOVER_TOKEN non-empty}"
: "${PUSHOVER_USER:?Need to set PUSHOVER_USER non-empty}"

cat << EOF > /etc/systemd/system/inactive-termination.service
[Unit]
Description=Inactive Termination Unit
After=systemd-user-sessions.service

[Service]
Type=simple
ExecStart=/etc/inactive-termination.sh
Environment=PUSHOVER_TOKEN=$PUSHOVER_TOKEN
Environment=PUSHOVER_USER=$PUSHOVER_USER
Restart=Always
EOF

cat << 'EOF' > /etc/inactive-termination.sh
#!/usr/bin/env bash

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

chmod +x /etc/inactive-termination.sh
