#!/bin/bash

# Variables
File1="grampsweb-users.tgz"
Volume1="grampsweb_users"
Folder1="/restore/${Volume1}"

# Seven more sets of file, volume, and folder variables
File2="grampsweb-index.tgz"
Volume2="grampsweb_indexdir"
Folder2="/restore/${Volume2}"

File3="grampsweb-thumbnails.tgz"
Volume3="grampsweb_thumb_cache"
Folder3="/restore/${Volume3}"

File4="grampsweb-cache.tgz"
Volume4="grampsweb_cache"
Folder4="/restore/${Volume4}"

File5="grampsweb-secret.tgz"
Volume5="grampsweb_secret"
Folder5="/restore/${Volume5}"

File6="grampsweb-db.tgz"
Volume6="grampsweb_db"
Folder6="/restore/${Volume6}"

File7="grampsweb-media.tgz"
Volume7="grampsweb_media"
Folder7="/restore/${Volume7}"

File8="grampsweb-tmp.tgz"
Volume8="grampsweb_tmp"
Folder8="/restore/${Volume8}"

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
    -v "$(pwd)/${File6}:/backup/${File6}" \
    -v "$(pwd)/${File7}:/backup/${File7}" \
    -v "$(pwd)/${File8}:/backup/${File8}" \
    -v "${Volume1}:${Folder1}" \
    -v "${Volume2}:${Folder2}" \
    -v "${Volume3}:${Folder3}" \
    -v "${Volume4}:${Folder4}" \
    -v "${Volume5}:${Folder5}" \
    -v "${Volume6}:${Folder6}" \
    -v "${Volume7}:${Folder7}" \
    -v "${Volume8}:${Folder8}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1} && \
        tar -xvzf /backup/${File2} -C ${Folder2} && \
        tar -xvzf /backup/${File3} -C ${Folder3} && \
        tar -xvzf /backup/${File4} -C ${Folder4} && \
        tar -xvzf /backup/${File5} -C ${Folder5} && \
        tar -xvzf /backup/${File6} -C ${Folder6} && \
        tar -xvzf /backup/${File7} -C ${Folder7} && \
        tar -xvzf /backup/${File8} -C ${Folder8}"


# Restore the site with the data
docker compose up -d
