FROM debian:stretch

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

ENV FASTCGI_TIMEOUT=1800 \
    PHP_MEMORY_LIMIT=512M \
    VHOST_NAME=default.conf \
    XDEBUG_REMOTE_HOST=127.0.0.1 \
    XDEBUG_REMOTE_PORT=9000 \
    TIME_ZONE="Europe/Warsaw"

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get clean && apt-get update \
    && apt-get -y --no-install-recommends install curl xz-utils cron nginx nginx-common nginx-extras inetutils-ping \
      supervisor dnsutils make vim git ssh mysql-client redis-tools php7.0 php7.0-fpm php7.0-dev php7.0-curl php7.0-gd \
      php7.0-intl php7.0-json php7.0-soap php7.0-phpdbg php7.0-redis php7.0-mysql php7.0-cli php7.0-mcrypt php7.0-opcache \
      php7.0-readline php7.0-memcached php7.0-zip php7.0-xsl php7.0-mbstring ca-certificates \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*\
    && update-ca-certificates

# Curl
ADD https://curl.haxx.se/ca/cacert.pem /var/www

# Dockerize
ADD https://github.com/jwilder/dockerize/releases/download/v0.5.0/dockerize-linux-amd64-v0.5.0.tar.gz /tmp/dockerize.tgz
RUN tar -C /usr/local/bin -xzf /tmp/dockerize.tgz \
    && rm /tmp/dockerize.tgz

# Composer
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod 755 /usr/local/bin/composer

# Magerun
ADD https://files.magerun.net/n98-magerun.phar /usr/local/bin/magerun
RUN chmod 755 /usr/local/bin/magerun

# Create mandatory paths:
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php7 \
    && mkdir /var/docker/php7/fpm \
    && mkdir /var/docker/php7/cli \
    && mkdir /var/docker/nginx

# Copy templates to Image:
COPY .docker/run.sh /var/docker/
COPY .docker/nginx/default.conf /var/docker/nginx/
COPY .docker/nginx/nginx.conf /var/docker/nginx/
COPY .docker/php7/xdebug.ini /var/docker/php7/
COPY .docker/php7/cli/php.ini /var/docker/php7/cli/
COPY .docker/php7/fpm/php.ini /var/docker/php7/fpm/
COPY .docker/php7/fpm/www.conf /var/docker/php7/fpm/
COPY .docker/supervisor/supervisord.conf /etc/supervisor/conf.d/
COPY .docker/tools/cli-debug /usr/local/bin/

# XDEBUG
ADD https://xdebug.org/files/xdebug-2.5.5.tgz /tmp/xdebug-2.5.5.tgz
RUN tar -C /var/local/ -xzf /tmp/xdebug-2.5.5.tgz
WORKDIR /var/local/xdebug-2.5.5
RUN phpize \
    && chmod u+x configure \
    && ./configure \
    && make \
    && cp /var/local/xdebug-2.5.5/modules/xdebug.so /usr/lib/php/20151012 \
    && touch /etc/php/7.0/mods-available/xdebug.ini \
    && ln -s /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini \
    && ln -s /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini \
    && rm /tmp/xdebug-2.5.5.tgz

# NODE, GRUNT
ADD https://nodejs.org/dist/v6.11.2/node-v6.11.2-linux-x64.tar.xz /tmp/node-v6.11.2-linux-x64.tar.xz
RUN unxz /tmp/node-v6.11.2-linux-x64.tar.xz \
    && tar -C /usr/local/ -xf /tmp/node-v6.11.2-linux-x64.tar \
    && rm /tmp/node-v6.11.2-linux-x64.tar \
    && export PATH=$PATH:/usr/local/node-v6.11.2-linux-x64/bin \
    && npm install -g grunt

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

RUN mkdir -p /run/php \
    && chmod 777 /var/docker/run.sh \
    && usermod -u 1000 www-data \
    && chsh -s /bin/bash www-data \
    && mkdir -p /var/www/current \
    && chown www-data:www-data -R /var/www

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 80
WORKDIR /var/www/current
CMD ["/var/docker/run.sh"]
