#!/bin/bash

# Set variables
BackupContainer="romm"

File2="romm-resources.tgz"
Folder2="/romm/resources"

File3="romm-database.tgz"
Folder3="/romm/database"

File4="romm-logs.tgz"
Folder4="/romm/logs"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder2} -cvzf /backup/${File2} . && \
    tar -C ${Folder3} -cvzf /backup/${File3} . && \
    tar -C ${Folder4} -cvzf /backup/${File4} ."

# Copy to external drive and overwrite if files already exist
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
cp "./${File3}" "${BackupFolder}/${dateString}/${File3}" -f
cp "./${File4}" "${BackupFolder}/${dateString}/${File4}" -f
