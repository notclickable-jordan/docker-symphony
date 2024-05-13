#!/bin/bash

# Variables
File1="jordanroher-content.tgz"
Volume1="jordanroher_content"
Folder1="/restore/${Volume1}"

File2="jordanroher-db.tgz"
Volume2="jordanroher_db"
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
