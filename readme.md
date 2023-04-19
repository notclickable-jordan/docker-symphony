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
- WikiJS - Roher Wiki (8060)
- Grafana
    - nginx stub_status (8070)
    - Prometheus (8071)
    - Grafana (8072)
- MeTube (8080)
- Homepage (8090)
- Gitea (8100)
- Mealie (8110)
- Visual Studio Code (8120)
- Vaultwarden (8130)
- N8N (8140)
- Ghost - Roher Twins (8150)
- Portainer (8160)
- Calibre (8170)
- Wallabag (8180)

# Automation

## Cron jobs

``` bash
crontab -e -u jordan

0 2 * * * /bin/bash /home/jordan/docker-symphony/nginx/renew.sh
0 3 * * * /bin/bash /home/jordan/docker-symphony/backup-all.sh
```

# DirectUpdate

Create a new DNS account:

- **Account Type:** NameCheap.com
- **User name/Login:** your-domain.tld (e.g.: mydomain.com)
- **Password:** the 25+ charater namecheap DDNS key your-domain.com (e.g. 78bb2321f2b777ff8c24c59234mkm3)
- **Domain/Host:** your-subdomain.your-domain.tld (e.g. mysubdomain.mydomain.com)
- Uncheck **Disable/ignore this account**