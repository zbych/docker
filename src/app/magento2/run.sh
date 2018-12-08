
# CONFIGURE APPLICATION

dockerize -template=/var/docker/etc/env.php:/var/www/current/app/etc/env.php
chmod 664 /var/www/current/app/etc/env.php
chown www-data:www-data /var/www/current/app/etc/env.php

# Clean logs
find /var/www/current/var -type f -iname "*.log" -delete
rm -rf /var/www/current/var/report

if [[ ! -f /var/www/current/nginx.conf ]]; then
    cp /var/www/current/nginx.conf.sample /var/www/current/nginx.conf
    chmod 664 /var/www/current/nginx.conf
    chown www-data:www-data /var/www/current/nginx.conf
fi

echo "Setting up cron..."
if [[ ! -f /var/docker/.built ]] ; then
    echo '* * * * * www-data cd /var/www/current/ && /usr/bin/php bin/magento cron:run >> /var/www/current/var/log/cron.log 2>&1' >> /etc/crontab
    echo '* * * * * www-data cd /var/www/current/ && /usr/bin/php bin/magento setup:cron:run >> /var/www/current/var/log/setup.cron.log 2>&1' >> /etc/crontab
fi

/usr/sbin/cron
