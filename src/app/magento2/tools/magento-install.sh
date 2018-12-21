#!/bin/sh

./bin/magento setup:install \
--base-url=http://$PROJECT.local \
--db-host=mysql \
--db-name=$DB_NAME \
--db-user=root \
--db-password=admin \
--admin-firstname=$APP_USER_FIRST_NAME \
--admin-lastname=$APP_USER_LAST_NAME \
--admin-email=$APP_USER_EMAIL \
--admin-user=$APP_USER_NAME \
--admin-password=$APP_USER_PASSWD \
--backend-frontname=admin \
--language=$APP_LOCALE \
--currency=$APP_CURRENCY \
--timezone=$APP_TIMEZONE \
--cleanup-database \
--session-save=db \
--use-rewrites=1