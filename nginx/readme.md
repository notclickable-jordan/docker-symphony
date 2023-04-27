# Authelia

Setting up two factor authentication requires clicking a link in an email.

Emails sent from this local server will not be delivered.

To get the link, open **env.authelia_notification.txt** in this folder.

# OIDC

Setting up OIDC for Outline authentication

1. Generate a private key
    ``` bash
    openssl genrsa -out authelia-private.pem 4096
    openssl rsa -in authelia-private.pem -outform PEM -pubout -out authelia-public.pem
    ```