FROM debian:jessie

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

ENV FASTCGI_TIMEOUT=1800 \
    PHP_MEMORY_LIMIT=512M \
    XDEBUG_REMOTE_PORT=9000 \
    XDEBUG_REMOTE_HOST=127.0.0.1 \
    TIME_ZONE="Europe/Warsaw"

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get -y --no-install-recommends install xz-utils cron curl nginx inetutils-ping supervisor dnsutils make vim \
        git ssh mysql-client redis-tools php5 php5-fpm php5-dev php5-curl php5-gd php5-intl php5-json php5-phpdbg \
        php5-redis php5-mysql php5-cli php5-mcrypt php5-apcu php-apc php5-readline php5-apcu php-pclzip php5-xsl \
        php5-xdebug bzip2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Curl
ADD https://curl.haxx.se/ca/cacert.pem /var/www

# Dockerize
ADD https://github.com/jwilder/dockerize/releases/download/v0.5.0/dockerize-linux-amd64-v0.5.0.tar.gz /tmp/dockerize.tgz
RUN tar -C /usr/local/bin -xzf /tmp/dockerize.tgz \
    && rm /tmp/dockerize.tgz

# Composer
ADD https://getcomposer.org/composer.phar /usr/local/bin/composer
RUN chmod +rx /usr/local/bin/composer

# Magerun
ADD https://files.magerun.net/n98-magerun.phar /usr/local/bin/magerun
RUN chmod +rx /usr/local/bin/magerun

# Dockerized files needs to be moved to TMP dir.
RUN mkdir /var/docker/ \
    && mkdir /var/docker/etc \
    && mkdir /var/docker/php5 \
    && mkdir /var/docker/php5/cli \
    && mkdir /var/docker/php5/fpm \
    && mkdir /var/docker/nginx

# Copy files to Image:
COPY .docker/run.sh /var/docker/
COPY .docker/nginx/default.conf /var/docker/nginx/
COPY .docker/nginx/nginx.conf /var/docker/nginx/
COPY .docker/php5/xdebug.ini /var/docker/php5/
COPY .docker/php5/cli/php.ini /var/docker/php5/cli/
COPY .docker/php5/fpm/php.ini /var/docker/php5/fpm/
COPY .docker/php5/fpm/www.conf /var/docker/php5/fpm/
COPY .docker/supervisor/supervisord.conf /etc/supervisor/conf.d/
COPY .docker/tools/cli-debug /usr/local/bin/
COPY .docker/etc/local.xml /var/docker/etc/

# NODE, GRUNT
workdir /root/
ADD https://nodejs.org/dist/v8.11.3/node-v8.11.3-linux-x64.tar.xz /tmp/node-v8.11.3-linux-x64.tar.xz
RUN unxz /tmp/node-v8.11.3-linux-x64.tar.xz \
    && tar -C /usr/local/ -xf /tmp/node-v8.11.3-linux-x64.tar \
    && rm /tmp/node-v8.11.3-linux-x64.tar \
    && export PATH=$PATH:/usr/local/node-v8.11.3-linux-x64/bin \
    && npm install -g gulp

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

RUN chmod 777 /var/docker/run.sh \
    && usermod -u 1000 www-data \
    && chsh -s /bin/bash www-data \
    && mkdir -p /var/www/current \
    && chown www-data:www-data -R /var/www

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 80
WORKDIR /var/www/current
CMD ["/var/docker/run.sh"]
