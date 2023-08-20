#!/bin/bash

# Variables
File2="romm-resources.tgz"
Volume2="romm_resources"
Folder2="/restore/${Volume2}"

File3="romm-database.tgz"
Volume3="romm_database"
Folder3="/restore/${Volume3}"

File4="romm-logs.tgz"
Volume4="romm_logs"
Folder4="/restore/${Volume4}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d --build romm
docker compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File2}:/backup/${File2}" \
    -v "$(pwd)/${File3}:/backup/${File3}" \
    -v "$(pwd)/${File4}:/backup/${File4}" \
    -v "${Volume2}:${Folder2}" \
    -v "${Volume3}:${Folder3}" \
    -v "${Volume4}:${Folder4}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File2} -C ${Folder2} && \
        tar -xvzf /backup/${File3} -C ${Folder3} && \
        tar -xvzf /backup/${File4} -C ${Folder4}"

# Restore the site with the data
docker compose up -d