
# CONFIGURE APPLICATION

dockerize -template=/var/docker/etc/env.php:%APP_PATH%/app/etc/env.php
chmod 664 %APP_PATH%/app/etc/env.php
chown www-data:www-data %APP_PATH%/app/etc/env.php

# Clean logs
find %APP_PATH%/var -type f -iname "*.log" -delete
rm -rf %APP_PATH%/var/report

if [[ ! -f %APP_PATH%/nginx.conf ]]; then
    cp %APP_PATH%/nginx.conf.sample %APP_PATH%/nginx.conf
    chmod 664 %APP_PATH%/nginx.conf
    chown www-data:www-data %APP_PATH%/nginx.conf
fi

echo "Setting up cron..."
if [[ ! -f /var/docker/.built ]] ; then
    echo '* * * * * www-data cd %APP_PATH% && /usr/bin/php bin/magento cron:run >> %APP_PATH%/var/log/cron.log 2>&1' >> /etc/crontab
    echo '* * * * * www-data cd %APP_PATH% && /usr/bin/php bin/magento setup:cron:run >> %APP_PATH%/var/log/setup.cron.log 2>&1' >> /etc/crontab
fi

