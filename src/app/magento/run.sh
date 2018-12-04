
# CONFIGURE APPLICATION

dockerize -template=/var/docker/etc/local.xml:/var/www/current/app/etc/local.xml /bin/true
chmod 664 /var/www/current/app/etc/local.xml
chown www-data:www-data /var/www/current/app/etc/local.xml

if [[ -f /var/docker/tools/local-update.sql ]]; then
    mkdir -p /var/www/current/var
    dockerize -template=/var/docker/tools/local-update.sql:/var/www/current/var/local-update.sql /bin/true
fi

# Clean logs
echo "" > /var/www/current/var/system.log
echo "" > /var/www/current/var/exception.log
echo "" > /var/www/current/var/cron.log

echo "Setting up cron..."
if ! grep -q "* * * * * www-data" /etc/crontab ; then
    echo '* * * * * www-data cd /var/www/current/ && /usr/bin/php cron.php >> /var/www/current/var/log/cron.log 2>&1' >> /etc/crontab
fi

/usr/sbin/cron
