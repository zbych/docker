
# CONFIGURE APPLICATION

dockerize -template=/var/docker/etc/env.php:/var/www/current/app/etc/env.php /bin/true
chmod 664 /var/www/current/app/etc/env.php
chown www-data:www-data /var/www/current/app/etc/env.php

# Clean logs
echo "" > /var/www/current/var/system.log
echo "" > /var/www/current/var/exception.log
echo "" > /var/www/current/var/debug.log
echo "" > /var/www/current/var/cron.log
rm -rf /var/www/current/var/report

if [[ -f /var/www/current/nginx.conf ]]; then
    cp /var/www/current/nginx.conf.sample /var/www/current/nginx.conf
    chmod 664 /var/www/current/nginx.conf
    chown www-data:www-data /var/www/current/nginx.conf
fi

if [[ -f /var/docker/tools/local-update.sql ]]; then
    mkdir -p /var/www/current/var
    dockerize -template=/var/docker/tools/local-update.sql:/var/www/current/var/local-update.sql /bin/true
fi

echo "Setting up cron..."
if ! grep -q "* * * * * www-data" /etc/crontab ; then
    echo '* * * * * www-data cd /var/www/current/ && /usr/bin/php bin/magento cron:run >> /var/www/current/var/log/cron.log 2>&1' >> /etc/crontab
    echo '* * * * * www-data cd /var/www/current/ && /usr/bin/php bin/magento setup:cron:run >> /var/www/current/var/log/setup.cron.log 2>&1' >> /etc/crontab
fi

/usr/sbin/cron