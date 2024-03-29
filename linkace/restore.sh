#!/bin/bash

# Variables
File1="linkace-db.tgz"
Volume1="linkace_db"
Folder1="/restore/${Volume1}"

File2="linkace-backups.tgz"
Volume2="linkace_backups"
Folder2="/restore/${Volume2}"

File3="linkace-app.tgz"
Volume3="linkace_app"
Folder3="/restore/${Volume3}"

File4="linkace-logs.tgz"
Volume4="linkace_logs"
Folder4="/restore/${Volume4}"

# Bring down the existing site
docker-compose down -v

# Bring up the containers to recreate the volumes
docker-compose up -d --build backup
docker-compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "$(pwd)/${File2}:/backup/${File2}" \
    -v "$(pwd)/${File3}:/backup/${File3}" \
    -v "$(pwd)/${File4}:/backup/${File4}" \
    -v "${Volume1}:${Folder1}" \
    -v "${Volume2}:${Folder2}" \
    -v "${Volume3}:${Folder3}" \
    -v "${Volume4}:${Folder4}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1} && \
        tar -xvzf /backup/${File2} -C ${Folder2} && \
        tar -xvzf /backup/${File3} -C ${Folder3} && \
        tar -xvzf /backup/${File4} -C ${Folder4}"

# Restore the site with the data
docker-compose up -d
