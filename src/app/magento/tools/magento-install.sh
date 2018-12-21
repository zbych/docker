#!/bin/sh

php -f install.php -- \
 --locale $APP_LOCALE \
 --license_agreement_accepted yes \
 --timezone $APP_TIMEZONE \
 --db_host mysql \
 --db_user admin \
 --db_pass root \
 --db_name $DB_NAME \
 --url "$PROJECT.local" \
 --use_rewrites yes \
 --use_secure no \
 --default_currency $APP_CURRENCY \
 --secure_base_url "$PROJECT.local" \
 --use_secure_admin no \
 --admin_firstname $APP_USER_FIRSTNAME \
 --admin_lastname $APP_USER_LASTNAME \
 --admin_email $APP_USER_EMAIL \
 --admin_username $APP_USER_NAME \
 --admin_password $APP_USER_PASSWD

