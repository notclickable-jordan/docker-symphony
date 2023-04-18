#!/bin/bash

# Variables
File3="nginx-letsencrypt.tgz"
Volume3="nginx_letsencrypt"
Folder3="/restore/${Volume3}"

# Bring down the existing site
docker-compose down -v

# Bring up the containers to recreate the volumes
docker-compose up -d --build backup
docker-compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "${Volume1}:${Folder1}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1}"

# Restore the site with the data
docker-compose up -d
