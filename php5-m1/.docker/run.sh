#!/bin/bash

# Configure Environment
dockerize \
    -template=/var/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -template=/var/docker/nginx/default.conf:/etc/nginx/sites-enabled/$SITE_DOMAIN.conf \
    -template=/var/docker/php5/cli/php.ini:/etc/php5/cli/php.ini \
    -template=/var/docker/php5/fpm/php.ini:/etc/php5/fpm/php.ini \
    -template=/var/docker/php5/fpm/www.conf:/etc/php5/fpm/pool.d/www.conf \
    -template=/var/docker/php5/xdebug.ini:/etc/php5/mods-available/xdebug.ini \
    /bin/true

# Clean logs
echo "" > /var/log/nginx/access.log
echo "" > /var/log/nginx/error.log
echo "" > /var/log/nginx/php5-fpm.log
echo "" > /var/www/current/var/system.log
echo "" > /var/www/current/var/exception.log

echo "Setting up SSH Keys"
mkdir -p /root/.ssh
mkdir -p /var/www/.ssh
cp /root/.ssh.back/* /root/.ssh/
cp /root/.ssh.back/* /var/www/.ssh/
chmod 600 /root/.ssh/id_rsa
chmod 600 /var/www/.ssh/id_rsa
chown www-data:www-data -R /var/www/.ssh/

echo "Setting up Composer"
mkdir -p /root/.composer
mkdir -p /var/www/.composer
cp /root/.composer.back/*.json /root/.composer/
cp /root/.composer.back/*.json /var/www/.composer/
chown www-data:www-data -R /var/www/.composer/

echo "Setting up cron..."
if ! grep -q "* * * * * www-data" /etc/crontab ;
then
    echo '* * * * * www-data cd /var/www/current/ && /usr/bin/php cron.php >> /var/www/current/var/log/cron.log 2>&1' >> /etc/crontab
fi
/usr/sbin/cron

echo "export PATH=\$PATH:/usr/local/node-v6.11.2-linux-x64/bin" > /var/www/.bashrc
echo "export PATH=\$PATH:/usr/local/node-v6.11.2-linux-x64/bin" >> /root/.bashrc

exec /usr/bin/supervisord