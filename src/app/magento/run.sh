
# CONFIGURE APPLICATION

dockerize -template=/var/docker/etc/local.xml:%APP_PATH%/app/etc/local.xml
chmod 664 %APP_PATH%/app/etc/local.xml
chown www-data:www-data %APP_PATH%/app/etc/local.xml

# Clean logs
find %APP_PATH%/var -type f -iname "*.log" -delete
rm -rf %APP_PATH%/var/report

echo "Setting up cron..."
if [[ ! -f /var/docker/.built ]] ; then
    echo '* * * * * www-data cd %APP_PATH% && /usr/bin/php cron.php >> %APP_PATH%/var/log/cron.log 2>&1' >> /etc/crontab
fi
