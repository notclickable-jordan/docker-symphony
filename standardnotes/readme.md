# Getting started

Give executable permission to localstack_bootstrap.sh

``` bash
chmod +x localstack_bootstrap.sh
```

# Subscriptions
To access server-side premium features, you'll need to create a subscription for your account (replace EMAIL@ADDR in the commands below with your user email). In order to do so, you'll need to run the following commands in your working directory:

``` bash
docker compose exec db sh -c "MYSQL_PWD=\$MYSQL_ROOT_PASSWORD mysql \$MYSQL_DATABASE -e \
    'INSERT INTO user_roles (role_uuid , user_uuid) VALUES ((SELECT uuid FROM roles WHERE name=\"PRO_USER\" ORDER BY version DESC limit 1) ,(SELECT uuid FROM users WHERE email=\"EMAIL@ADDR\")) ON DUPLICATE KEY UPDATE role_uuid = VALUES(role_uuid);' \
"

docker compose exec db sh -c "MYSQL_PWD=\$MYSQL_ROOT_PASSWORD mysql \$MYSQL_DATABASE -e \
    'INSERT INTO user_subscriptions SET uuid=UUID(), plan_name=\"PRO_PLAN\", ends_at=8640000000000000, created_at=0, updated_at=0, user_uuid=(SELECT uuid FROM users WHERE email=\"EMAIL@ADDR\"), subscription_id=1, subscription_type=\"regular\";' \
"
```