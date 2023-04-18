#!/bin/bash

# Set variables
BackupContainer="miniflux_backup"

File1="miniflux-db.tgz"
Folder1="/var/lib/postgresql/data"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
