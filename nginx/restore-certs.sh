#!/bin/bash

# Variables
File1="nginx-letsencrypt.tgz"
VolumeName="nginx_letsencrypt"
FolderName="/restore/${VolumeName}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d --build backup
docker compose down

# Restore the volume data from the backups
# Using Ubuntu because its build of tar includes the --skip-old-files flag
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "${VolumeName}:${FolderName}" \
    ubuntu sh -c \
        "tar -xvzf /backup/${File1} -C ${FolderName} --skip-old-files"

# Restore the site with the data
docker compose up -d
