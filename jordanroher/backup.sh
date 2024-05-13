#!/bin/bash

# Set variables
BackupContainer="jordanroher_backup"

File1="jordanroher-content.tgz"
Folder1="/var/lib/ghost/content"

File2="jordanroher-db.tgz"
Folder2="/var/lib/mysql"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
