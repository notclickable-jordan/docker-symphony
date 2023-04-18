#!/bin/bash

# Run letsencrypt container and remove it after it exits
docker compose run --rm letsencrypt

# Reload nginx configuration in the switchboard container
docker exec switchboard nginx -s reload
