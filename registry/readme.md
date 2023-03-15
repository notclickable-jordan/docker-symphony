# Steps

1. Pull a registry image
    ```bash
    docker pull nginx:1.23.3
    ```
1. Tag it to the local registry
    ```bash
    docker tag nginx:1.23.3 localhost:8020/not-clickable-nginx
    ```
1. Push it to the local registry
    ```bash
    docker push localhost:8020/not-clickable-nginx
    ```
1. Remove the locally-cached images
    ```bash
    docker image remove nginx:1.23.3
    docker image remove localhost:8020/not-clickable-nginx
    ```
1. Pull the image from the local registry
    ```bash
    docker pull localhost:8020/not-clickable-nginx
    ```

# Images in use

## Find

macOS command:
``` bash
find /path/to/search -name docker-compose.yml -exec grep -oE 'image:[[:space:]]+[a-zA-Z0-9/_-]+(?::[a-zA-Z0-9._-]+)' {} \; | awk '{print $2}' | sort | uniq
```

PowerShell:
``` powershell
Get-ChildItem -Path "C:\path\to\search" -Recurse -Filter "docker-compose.yml" | ForEach-Object { Get-Content $_.FullName | Select-String -Pattern 'image:\s+[a-zA-Z0-9/_-]+:[a-zA-Z0-9._-]+' -AllMatches | ForEach-Object { $_.Matches.Value } } | Sort-Object | Get-Unique
```

## List

1. alpine:3.17.2
1. bitwarden/server:2023.2.1
1. certbot/certbot:v2.4.0
1. itzg/minecraft-bedrock-server:latest
1. linuxserver/calibre-web:0.6.19
1. mariadb:10
1. miniflux/miniflux:2.0.42
1. nginx:1.23.3
1. postgres:14-alpine
1. postgres:15
1. redis:7-alpine
1. registry:2
1. tootsuite/mastodon:v4.1.0

# Commands

``` bash
# Pull these images
docker pull alpine:3.17.2 && \
docker pull bitwarden/server:2023.2.1 && \
docker pull certbot/certbot:v2.4.0 && \
docker pull itzg/minecraft-bedrock-server:latest && \
docker pull linuxserver/calibre-web:0.6.19 && \
docker pull mariadb:10 && \
docker pull miniflux/miniflux:2.0.42 && \
docker pull nginx:1.23.3 && \
docker pull postgres:14-alpine && \
docker pull postgres:15 && \
docker pull redis:7-alpine && \
docker pull registry:2 && \
docker pull tootsuite/mastodon:v4.1.0

# Tag them to the local registry
docker tag alpine:3.17.2 localhost:8020/not-clickable-alpine && \
docker tag bitwarden/server:2023.2.1 localhost:8020/not-clickable-bitwarden-server && \
docker tag certbot/certbot:v2.4.0 localhost:8020/not-clickable-certbot-certbot && \
docker tag itzg/minecraft-bedrock-server:latest localhost:8020/not-clickable-itzg-minecraft-bedrock-server && \
docker tag linuxserver/calibre-web:0.6.19 localhost:8020/not-clickable-linuxserver-calibre-web && \
docker tag mariadb:10 localhost:8020/not-clickable-mariadb && \
docker tag miniflux/miniflux:2.0.42 localhost:8020/not-clickable-miniflux-miniflux && \
docker tag nginx:1.23.3 localhost:8020/not-clickable-nginx && \
docker tag postgres:14-alpine localhost:8020/not-clickable-postgres-14 && \
docker tag postgres:15 localhost:8020/not-clickable-postgres-15 && \
docker tag redis:7-alpine localhost:8020/not-clickable-redis && \
docker tag registry:2 localhost:8020/not-clickable-registry && \
docker tag tootsuite/mastodon:v4.1.0 localhost:8020/not-clickable-tootsuite-mastodon

# Push them to the local registry like so: docker push localhost:8020/not-clickable-nginx
docker push localhost:8020/not-clickable-alpine && \
docker push localhost:8020/not-clickable-bitwarden-server && \
docker push localhost:8020/not-clickable-certbot-certbot && \
docker push localhost:8020/not-clickable-itzg-minecraft-bedrock-server && \
docker push localhost:8020/not-clickable-linuxserver-calibre-web && \
docker push localhost:8020/not-clickable-mariadb && \
docker push localhost:8020/not-clickable-miniflux-miniflux && \
docker push localhost:8020/not-clickable-nginx && \
docker push localhost:8020/not-clickable-postgres-14 && \
docker push localhost:8020/not-clickable-postgres-15 && \
docker push localhost:8020/not-clickable-redis && \
docker push localhost:8020/not-clickable-registry && \
docker push localhost:8020/not-clickable-tootsuite-mastodon

# Remove images
docker image rm alpine:3.17.2 bitwarden/server:2023.2.1 certbot/certbot:v2.4.0 itzg/minecraft-bedrock-server:latest linuxserver/calibre-web:0.6.19 mariadb:10 miniflux/miniflux:2.0.42 nginx:1.23.3 postgres:14-alpine postgres:15 redis:7-alpine registry:2 tootsuite/mastodon:v4.1.0

docker image rm localhost:8020/not-clickable-alpine localhost:8020/not-clickable-bitwarden-server localhost:8020/not-clickable-certbot-certbot localhost:8020/not-clickable-itzg-minecraft-bedrock-server localhost:8020/not-clickable-linuxserver-calibre-web localhost:8020/not-clickable-mariadb localhost:8020/not-clickable-miniflux-miniflux localhost:8020/not-clickable-nginx localhost:8020/not-clickable-postgres-14 localhost:8020/not-clickable-postgres-15 localhost:8020/not-clickable-redis localhost:8020/not-clickable-tootsuite-mastodon

# Pull the images from the local registry
docker pull localhost:8020/not-clickable-alpine && \
docker pull localhost:8020/not-clickable-bitwarden-server && \
docker pull localhost:8020/not-clickable-certbot-certbot && \
docker pull localhost:8020/not-clickable-itzg-minecraft-bedrock-server && \
docker pull localhost:8020/not-clickable-linuxserver-calibre-web && \
docker pull localhost:8020/not-clickable-mariadb && \
docker pull localhost:8020/not-clickable-miniflux-miniflux && \
docker pull localhost:8020/not-clickable-nginx && \
docker pull localhost:8020/not-clickable-postgres-14 && \
docker pull localhost:8020/not-clickable-postgres-15 && \
docker pull localhost:8020/not-clickable-redis && \
docker pull localhost:8020/not-clickable-registry && \
docker pull localhost:8020/not-clickable-tootsuite-mastodon
```