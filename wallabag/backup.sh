#!/bin/bash

# Set variables
BackupContainer="wallabag_backup"

File1="wallabag-images.tgz"
Folder1="/var/www/wallabag/web/assets/images"

File2="wallabag-data.tgz"
Folder2="/var/lib/mysql"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
