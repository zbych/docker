# Docker Entrypoint

dockerize \
    -template=/var/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -template=/var/docker/nginx/$VHOST_NAME:/etc/nginx/sites-enabled/$PROJECT.conf

echo "Setting up Composer"
mkdir -p /root/.composer
mkdir -p /var/www/.composer
cp /root/.composer.back/*.json /root/.composer/
cp /root/.composer.back/*.json /var/www/.composer/
chown www-data:www-data -R /var/www/.composer/

echo "Setting up SSH Keys"
mkdir -p /root/.ssh
mkdir -p /var/www/.ssh
cp /root/.ssh.back/* /root/.ssh/
cp /root/.ssh.back/* /var/www/.ssh/
chmod 600 /root/.ssh/id_rsa
chmod 600 /var/www/.ssh/id_rsa
chown www-data:www-data -R /var/www/.ssh/

if ! grep -q "/usr/local/node" /root/.bashrc ;
then
    echo "export PATH=\$PATH:/usr/local/node-v8.11.4-linux-x64/bin" > /var/www/.bashrc
    echo "export PATH=\$PATH:/usr/local/node-v8.11.4-linux-x64/bin" >> /root/.bashrc
fi

#_ENVIRONMENT_

#_APPLICATION_

exec /usr/bin/supervisord