#!/bin/bash

# Variables
File1="nginx-certbot.tgz"
Volume1="nginx_certbot"
Folder1="/restore/${Volume1}"

File2="nginx-grafana.tgz"
Volume2="nginx_grafana"
Folder2="/restore/${Volume2}"

File3="nginx-letsencrypt.tgz"
Volume3="nginx_letsencrypt"
Folder3="/restore/${Volume3}"

File4="nginx-logs.tgz"
Volume4="nginx_logs"
Folder4="/restore/${Volume4}"

File5="nginx-loki.tgz"
Volume5="nginx_loki"
Folder5="/restore/${Volume5}"

File6="nginx-prometheus.tgz"
Volume6="nginx_prometheus"
Folder6="/restore/${Volume6}"

# Bring down the existing site
docker-compose down -v

# Bring up the containers to recreate the volumes
docker-compose up -d --build backup
docker-compose down

# Restore the volume data from the backups
docker run --rm \
    -v "$(pwd)/${File1}:/backup/${File1}" \
    -v "$(pwd)/${File2}:/backup/${File2}" \
    -v "$(pwd)/${File3}:/backup/${File3}" \
    -v "$(pwd)/${File4}:/backup/${File4}" \
    -v "$(pwd)/${File5}:/backup/${File5}" \
    -v "$(pwd)/${File6}:/backup/${File6}" \
    -v "${Volume1}:${Folder1}" \
    -v "${Volume2}:${Folder2}" \
    -v "${Volume3}:${Folder3}" \
    -v "${Volume4}:${Folder4}" \
    -v "${Volume5}:${Folder5}" \
    -v "${Volume6}:${Folder6}" \
    alpine:3.17.2 sh -c \
        "tar -xvzf /backup/${File1} -C ${Folder1} && \
        tar -xvzf /backup/${File2} -C ${Folder2} && \
        tar -xvzf /backup/${File3} -C ${Folder3} && \
        tar -xvzf /backup/${File4} -C ${Folder4} && \
        tar -xvzf /backup/${File5} -C ${Folder5} && \
        tar -xvzf /backup/${File6} -C ${Folder6}"

# Restore the site with the data
docker-compose up -d
