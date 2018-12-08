#!/bin/bash

# DOCKER ENTRY-POINT

dockerize \
    -template=/var/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -template=/var/docker/nginx/sites-available/$VHOST_NAME:/etc/nginx/sites-enabled/$PROJECT.conf

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

if [[ ! -f /var/docker/.built ]] ; then
    # SQL Tools
    if [[ -d /var/docker/sql ]] ; then
        mkdir -p /var/www/current/var/sql
        dockerize -template=/var/docker/sql:/var/www/current/var/sql
        chown www-data:www-data -R /var/www/current/var/sql
    fi

    # Configure Node
    echo "export PATH=\$PATH:/usr/local/node-$NODE_VERSION-linux-x64/bin" > /var/www/.bashrc
    echo "export PATH=\$PATH:/usr/local/node-$NODE_VERSION-linux-x64/bin" >> /root/.bashrc

    # Hosts
    echo "127.0.0.1 $PROJECT.local" >> /etc/hosts
fi

#_ENVIRONMENT_

#_APPLICATION_

# Set container as built
date > /var/docker/.built

exec /usr/bin/supervisord