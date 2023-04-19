#!/bin/bash

# Set variables
BackupContainer="standardnotes_backup"

File1="standardnotes-logs.tgz"
Folder1="/var/lib/server/logs"

File2="standardnotes-uploads.tgz"
Folder2="/opt/bundled/files/packages/files/dist/uploads"

File3="standardnotes-mysql.tgz"
Folder3="/var/lib/mysql"

File4="standardnotes-import.tgz"
Folder4="/docker-entrypoint-initdb.d"

File5="standardnotes-redis.tgz"
Folder5="/data"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} . && \
    tar -C ${Folder3} -cvzf /backup/${File3} . && \
    tar -C ${Folder4} -cvzf /backup/${File4} . && \
    tar -C ${Folder5} -cvzf /backup/${File5} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
cp "./${File3}" "${BackupFolder}/${dateString}/${File3}" -f
cp "./${File4}" "${BackupFolder}/${dateString}/${File4}" -f
cp "./${File5}" "${BackupFolder}/${dateString}/${File5}" -f
