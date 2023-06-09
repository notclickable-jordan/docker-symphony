#!/bin/bash

# Variables
File1="n8n-data.tgz"
Volume1="n8n_data"
Folder1="/restore/${Volume1}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d --build n8n
docker compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "${Volume1}:${Folder1}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1}"

# Restore the site with the data
docker compose up -d
