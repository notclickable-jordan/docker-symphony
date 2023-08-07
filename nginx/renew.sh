#!/bin/bash
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"

# Log file path
LOG_FILE="/home/jordan/cron/renew.log"

# Truncate log file to 1 megabyte
truncate -s 1M "$LOG_FILE"

# Redirect stdout and stderr to the log file
exec &>> "$LOG_FILE"

echo "nginx/renew.sh: $(date)"

# Run letsencrypt container and remove it after it exits
docker compose -f /home/jordan/docker-symphony/nginx/compose.yml run --rm --workdir /home/jordan/docker-symphony/nginx letsencrypt

# Reload nginx configuration in the switchboard container
cd /home/jordan/docker-symphony/nginx;docker exec switchboard nginx -s reload
