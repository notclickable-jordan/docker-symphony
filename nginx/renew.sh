#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
cd /home/jordan

# Log file path
LOG_FILE="/home/jordan/cron/renew.log"

# Redirect stdout and stderr to the log file
exec &>> "$LOG_FILE"

# Run letsencrypt container and remove it after it exits
docker compose run --rm letsencrypt

# Reload nginx configuration in the switchboard container
docker exec switchboard nginx -s reload
