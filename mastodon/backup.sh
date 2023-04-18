#!/bin/bash

# Set variables
BackupContainer="jellyfin_backup"

File1="mastodon-web.tgz"
Folder1="/mastodon/public/system"

File2="mastodon-redis.tgz"
Folder2="/data"

File3="mastodon-db.tgz"
Folder3="/var/lib/postgresql/data"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} . && \
    tar -C ${Folder3} -cvzf /backup/${File3} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
cp "./${File3}" "${BackupFolder}/${dateString}/${File3}" -f
