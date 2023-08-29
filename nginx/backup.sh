#!/bin/bash

# Set variables
BackupContainer="switchboard_backup"

File1="nginx-letsencrypt.tgz"
Folder1="/etc/letsencrypt"

File2="nginx-authelia-db.tgz"
Folder2="/var/lib/postgresql/data"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
