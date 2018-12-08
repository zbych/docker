
# CONFIGURE APPLICATION

dockerize -template=/var/docker/etc/local.xml:/var/www/current/app/etc/local.xml
chmod 664 /var/www/current/app/etc/local.xml
chown www-data:www-data /var/www/current/app/etc/local.xml

# Clean logs
find /var/www/current/var -type f -iname "*.log" -delete
rm -rf /var/www/current/var/report

echo "Setting up cron..."
if [[ ! -f /var/docker/.built ]] ; then
    echo '* * * * * www-data cd /var/www/current/ && /usr/bin/php cron.php >> /var/www/current/var/log/cron.log 2>&1' >> /etc/crontab
fi

/usr/sbin/cron
