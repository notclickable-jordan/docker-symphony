#!/bin/bash

# Variables
File1="outline-db.tgz"
Volume1="outline_db"
Folder1="/restore/${Volume1}"

File2="outline-data.tgz"
Volume2="outline_data"
Folder2="/restore/${Volume2}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d --build backup
docker compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "$(pwd)/${File2}:/backup/${File2}" \
    -v "${Volume1}:${Folder1}" \
    -v "${Volume2}:${Folder2}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1} && \
        tar -xvzf /backup/${File2} -C ${Folder2}"


# Restore the site with the data
docker compose up -d
