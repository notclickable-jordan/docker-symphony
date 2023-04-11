# About

Docker compose files for personal services. Some services are exposed to the Internet, others are served to the local network and any devices using Tailscale. DNS records are updated using DirectUpdate.

## Prerequisites

- [Docker](https://www.docker.com/products/docker-desktop/)
- [Tailscale](https://tailscale.com/download/)
- [DirectUpdate](https://www.directupdate.net/)

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
- N8N (8140)
- Ghost (8150)
- GitLab (8160-8162)

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

## MeTube move files

Since MeTube isn't able to access the network share, its move files script should be run as a scheduled task (e.g. every 5 minutes).

``` powershell
./metube/powershell.exe -ExecutionPolicy Bypass -File move.ps1
```

# DirectUpdate

Create a new DNS account:

- **Account Type:** NameCheap.com
- **User name/Login:** your-domain.tld (e.g.: mydomain.com)
- **Password:** the 25+ charater namecheap DDNS key your-domain.com (e.g. 78bb2321f2b777ff8c24c59234mkm3)
- **Domain/Host:** your-subdomain.your-domain.tld (e.g. mysubdomain.mydomain.com)
- Uncheck **Disable/ignore this account**