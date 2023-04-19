#!/bin/bash

# Variables
File1="standardnotes-logs.tgz"
Volume1="standardnotes_logs"
Folder1="/restore/${Volume1}"

File2="standardnotes-uploads.tgz"
Volume2="standardnotes_uploads"
Folder2="/restore/${Volume2}"

File3="standardnotes-mysql.tgz"
Volume3="standardnotes_mysql"
Folder3="/restore/${Volume3}"

File4="standardnotes-import.tgz"
Volume4="standardnotes_import"
Folder4="/restore/${Volume3}"

File5="standardnotes-redis.tgz"
Volume5="standardnotes_redis"
Folder5="/restore/${Volume3}"

# Bring down the existing site
docker compose down -v

# Bring up the containers to recreate the volumes
docker compose up -d --build backup
docker compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "$(pwd)/${File2}:/backup/${File2}" \
    -v "$(pwd)/${File3}:/backup/${File3}" \
    -v "$(pwd)/${File4}:/backup/${File4}" \
    -v "$(pwd)/${File5}:/backup/${File5}" \
    -v "${Volume1}:${Folder1}" \
    -v "${Volume2}:${Folder2}" \
    -v "${Volume3}:${Folder3}" \
    -v "${Volume4}:${Folder4}" \
    -v "${Volume5}:${Folder5}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1} && \
        tar -xvzf /backup/${File2} -C ${Folder2} && \
        tar -xvzf /backup/${File3} -C ${Folder3} && \
        tar -xvzf /backup/${File4} -C ${Folder4} && \
        tar -xvzf /backup/${File5} -C ${Folder5}"


# Restore the site with the data
docker compose up -d
