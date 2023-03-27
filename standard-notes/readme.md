# Installation

1. Gave the bootstrap script executable permissions
    ``` powershell
    chmod +x ./localstack_bootstrap.sh
    ```
1. Started up docker containers
    ``` bash
    docker compose up -d
    ```
1. Created account on web interface
1. Ran this command
    ``` bash
    docker compose exec db sh -c "MYSQL_PWD=<PASSWORD> mysql standard_notes_db -e 'INSERT INTO user_roles (role_uuid , user_uuid) VALUES ((SELECT uuid FROM roles WHERE name=\"PRO_USER\" ORDER BY version DESC limit 1) ,(SELECT uuid FROM users WHERE email=\"jordan@notclickable.com\")) ON DUPLICATE KEY UPDATE role_uuid = VALUES(role_uuid);'"

    docker compose exec db sh -c "MYSQL_PWD=<PASSWORD> mysql standard_notes_db -e 'INSERT INTO user_subscriptions SET uuid=UUID(), plan_name=\"PRO_PLAN\", ends_at=8640000000000000, created_at=0, updated_at=0, user_uuid=(SELECT uuid FROM users WHERE email=\"jordan@notclickable.com\"), subscription_id=1, subscription_type=\"regular\";'"
    ```
1. Reload web interface, sign in again