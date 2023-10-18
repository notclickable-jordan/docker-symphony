#!/bin/bash

# Set variables
BackupContainer="gitlab"

File1="gitlab-config.tgz"
Folder1="/etc/gitlab"

File2="gitlab-logs.tgz"
Folder2="/var/log/gitlab"

File3="gitlab-data.tgz"
Folder3="/var/opt/gitlab"

File4="gitlab-runner.tgz"
Folder4="/etc/gitlab-runner"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} . && \
    tar -C ${Folder3} -cvzf /backup/${File3} . && \
    tar -C ${Folder4} -cvzf /backup/${File4} . "

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
cp "./${File3}" "${BackupFolder}/${dateString}/${File3}" -f
cp "./${File4}" "${BackupFolder}/${dateString}/${File4}" -f
