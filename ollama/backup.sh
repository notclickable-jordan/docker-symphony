#!/bin/bash

# Set variables
BackupContainer="ollama-webui"

File1="ollama-webui-data.tgz"
Folder1="/app/backend/data"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
