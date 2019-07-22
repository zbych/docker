#!/bin/bash

# DOCKER ENTRY-POINT

dockerize \
    -template=/var/docker/nginx/nginx.conf:/etc/nginx/nginx.conf \
    -template=/var/docker/nginx/sites-available/$VHOST_NAME:/etc/nginx/sites-enabled/$PROJECT.conf

if [[ ! -f /var/docker/.built ]] ; then

    # User Keys
    echo "Setting up SSH and Composer keys"
    mkdir -p /var/www/.composer
    mkdir -p /var/www/.ssh
    cp /root/.composer/*.json /var/www/.composer
    cp /root/.ssh/* /var/www/.ssh/
    chmod 600 /var/www/.ssh/id_rsa

    # SQL Tools
    if [[ -d /var/docker/sql ]] ; then
        mkdir -p %APP_PATH%/var/sql
        dockerize -template=/var/docker/sql:%APP_PATH%/var/sql
        chown www-data:www-data -R %APP_PATH%/var/sql
    fi

    # Configure Node
    echo "export PATH=\$PATH:/var/www/bin:/var/www/bin/node-$NODE_VERSION-linux-x64/bin" > /var/www/.bashrc

    # SSL
    mkdir /etc/nginx/ssl -p \
        && openssl req -x509 -newkey rsa:4096 -keyout /etc/nginx/ssl/$PROJECT.key -out /etc/nginx/ssl/$PROJECT.crt -nodes -days 365 \
        -subj "/C=US/ST=Unknown/L=Unknown/O=$PROJECT/OU=Org/CN=$PROJECT.local"

    # Privileges
    echo "Setting Privileges"
    chown www-data:www:data /var/www
    ls -d /var/www/* | grep -v htdocs | xargs chown www-data:www-data -R
    chown www-data:www-data -R /var/www/.[^.]*
fi

#_ENVIRONMENT_

# Hosts
echo "127.0.0.1 $PROJECT.local" >> /etc/hosts

#_APPLICATION_

# Set container as built
date > /var/docker/.built

exec /usr/bin/supervisord