#!/bin/bash

# Variables
File1="gitlab-config.tgz"
Volume1="gitlab_config"
Folder1="/restore/${Volume1}"

File2="gitlab-logs.tgz"
Volume2="gitlab_logs"
Folder2="/restore/${Volume2}"

File3="gitlab-data.tgz"
Volume3="gitlab_data"
Folder3="/restore/${Volume3}"

# Bring down the existing site
docker-compose down -v

# Bring up the containers to recreate the volumes
docker-compose up -d --build gitlab
docker-compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "$(pwd)/${File2}:/backup/${File2}" \
    -v "$(pwd)/${File3}:/backup/${File3}" \
    -v "${Volume1}:${Folder1}" \
    -v "${Volume2}:${Folder2}" \
    -v "${Volume3}:${Folder3}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1} && \
        tar -xvzf /backup/${File2} -C ${Folder2} && \
        tar -xvzf /backup/${File3} -C ${Folder3}"

# Restore the site with the data
docker-compose up -d
