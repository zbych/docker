#!/bin/bash

# DOCKER ENTRY-POINT

dockerize \
    -template=/var/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -template=/var/docker/nginx/sites-available/$VHOST_NAME:/etc/nginx/sites-enabled/$PROJECT.conf

echo "Setting up SSH and Composer keys"
mkdir -p /var/www/.composer
mkdir -p /var/www/.ssh
cp /root/.composer/*.json /var/www/.composer
cp /root/.ssh/* /var/www/.ssh/
chmod 600 /var/www/.ssh/id_rsa

echo "Setting Privileges"
chown www-data:www-data -R /var/www
ls -a /var/www | egrep '^\.[a-z]' | xargs chown -R www-data:www-data

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