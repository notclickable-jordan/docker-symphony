# About

Docker compose files for personal services. Some services are exposed to the Internet, others are served to the local network and any devices using Tailscale.

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop/)
- [Tailscale](https://tailscale.com/download/)

## Environment variables

Many services mention `env_file` in their `compose.yml`. These are stored in 1Password and must be manually created in each folder.

# Services and ports

## TCP
- nginx (80, 443)
- Mastodon (8010-8013)
- Archivebox (8020)
- Jellyfin (8030)
- Calibre (8040)
- Miniflux (8050)
- WikiJS (8060)
- Grafana
    - nginx stub_status (8070)
    - Prometheus (8071)
    - Grafana (8072)
- MeTube (8080)
- Homepage (8090)
- Gitea (8100)
- Mealie (8110)
- Visual Studio Code (8120)
- Vaultwarden (8130-8132)

## UDP
- Minecraft (19132)

## Exposed to the Internet

- nginx
- Mastodon ([notclickable.social](https://notclickable.social))
- Homepage ([notclickable.com](https://notclickable.com))
- Vaultwarden ([vaultwarden.notclickable.com](https://vaultwarden.notclickable.com))

# Scripts

## Backup

Use the `backup-all.ps1` script to backup all services. New services must be added manually to this file. Individual backup scripts may not be run in isolation.

``` powershell
powershell.exe -ExecutionPolicy Bypass -File backup-all.ps1
```

## Restore

Paste the appropriate `.tgz` files into the folder for each service and run the restore script to load data into Docker volumes.

``` powershell
powershell.exe -ExecutionPolicy Bypass -File restore.ps1
```

## SSL certificate renewal

Use the `renew-all.ps1` script to renew the SSL certificates for services exposed to the Internet. New services must be added manually to this file. Individual renewal scripts may be run in isolation.

``` powershell
powershell.exe -ExecutionPolicy Bypass -File renew-all.ps1
```