#!/bin/bash

# Set variables
BackupContainer="grampsweb"

File1="grampsweb-users.tgz"
Folder1="/app/users"

File2="grampsweb-index.tgz"
Folder2="/app/indexdir"

File3="grampsweb-thumbnails.tgz"
Folder3="/app/thumbnail_cache"

File4="grampsweb-cache.tgz"
Folder4="/app/cache"

File5="grampsweb-secret.tgz"
Folder5="/app/secret"

File6="grampsweb-db.tgz"
Folder6="/root/.gramps/grampsdb"

File7="grampsweb-media.tgz"
Folder7="/app/media"

File8="grampsweb-tmp.tgz"
Folder8="/tmp"

# Backup existing volumes by tarring and gzipping them
docker run --rm --volumes-from ${BackupContainer} \
    -v $(pwd):/backup ${Image} sh -c \
    "tar -C ${Folder1} -cvzf /backup/${File1} . && \
    tar -C ${Folder2} -cvzf /backup/${File2} . && \
    tar -C ${Folder3} -cvzf /backup/${File3} . && \
    tar -C ${Folder4} -cvzf /backup/${File4} . && \
    tar -C ${Folder5} -cvzf /backup/${File5} . && \
    tar -C ${Folder6} -cvzf /backup/${File6} . && \
    tar -C ${Folder7} -cvzf /backup/${File7} . && \
    tar -C ${Folder8} -cvzf /backup/${File8} ."

# Copy to external drive and overwrite if files already exist
cp "./${File1}" "${BackupFolder}/${dateString}/${File1}" -f
cp "./${File2}" "${BackupFolder}/${dateString}/${File2}" -f
cp "./${File3}" "${BackupFolder}/${dateString}/${File3}" -f
cp "./${File4}" "${BackupFolder}/${dateString}/${File4}" -f
cp "./${File5}" "${BackupFolder}/${dateString}/${File5}" -f
cp "./${File6}" "${BackupFolder}/${dateString}/${File6}" -f
cp "./${File7}" "${BackupFolder}/${dateString}/${File7}" -f
cp "./${File8}" "${BackupFolder}/${dateString}/${File8}" -f
