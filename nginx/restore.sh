#!/bin/bash

# Variables
File1="nginx-letsencrypt.tgz"
VolumeName1="nginx_letsencrypt"
FolderName1="/restore/${VolumeName1}"

File2="authelia-db.tgz"
VolumeName2="authelia_db"
FolderName2="/restore/${VolumeName2}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d --build backup
docker compose down

# Restore the volume data from the backups
# Using Ubuntu because its build of tar includes the --skip-old-files flag
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "$(pwd)/${File2}:/backup/${File2}" \
    -v "${VolumeName1}:${FolderName1}" \
    -v "${VolumeName2}:${FolderName2}" \
    ubuntu sh -c \
        "tar -xvzf /backup/${File1} -C ${FolderName1} --skip-old-files && \
        tar -xvzf /backup/${File2} -C ${FolderName2}"

# Restore the site with the data
docker compose up -d
