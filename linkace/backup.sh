#!/bin/bash

# Set variables
BackupContainer="linkace_backup"

File1="linkace-db.tgz"
Folder1="/var/lib/mysql"

File2="linkace-backups.tgz"
Folder2="/app/storage/app/backups"

File3="linkace-app.tgz"
Folder3="/app"

File4="linkace-logs.tgz"
Folder4="/app/storage/logs"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} . && \
    tar -C ${Folder3} -cvzf /backup/${File3} . && \
    tar -C ${Folder4} -cvzf /backup/${File4} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
cp "./${File3}" "${BackupFolder}/${dateString}/${File3}" -f
cp "./${File4}" "${BackupFolder}/${dateString}/${File4}" -f
