FROM debian:stretch

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

ENV FASTCGI_TIMEOUT=1800 \
    PHP_MEMORY_LIMIT=512M \
    VHOST_NAME=default.conf \
    XDEBUG_REMOTE_HOST=172.17.0.1 \
    XDEBUG_REMOTE_PORT=9000 \
    TIME_ZONE="Europe/Warsaw"

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get clean && apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates apt-transport-https wget gnupg gnupg2 lsb-release \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list' \
    && apt-get update \
    && apt-get -y --no-install-recommends install curl xz-utils cron nginx nginx-common nginx-extras inetutils-ping \
      supervisor dnsutils make vim git ssh mysql-client redis-tools php7.1 php7.1-fpm php7.1-dev php7.1-curl php7.1-gd \
      php7.1-intl php7.1-json php7.1-soap php7.1-phpdbg php7.1-redis php7.1-mysql php7.1-cli php7.1-mcrypt php7.1-opcache \
      php7.1-readline php7.1-memcached php7.1-zip php7.1-xsl php7.1-mbstring php7.1-bcmath php7.1-soap bzip2 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
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
ADD https://files.magerun.net/n98-magerun2.phar /usr/local/bin/magerun
RUN chmod 755 /usr/local/bin/magerun

# Create mandatory paths:
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php7 \
    && mkdir /var/docker/php7/fpm \
    && mkdir /var/docker/php7/cli \
    && mkdir /var/docker/nginx \
    && mkdir /var/docker/etc

# Copy templates to Image:
COPY .docker/run.sh /var/docker/
COPY .docker/nginx/default.conf /var/docker/nginx/
COPY .docker/nginx/magento.conf /var/docker/nginx/
COPY .docker/nginx/nginx.conf /var/docker/nginx/
COPY .docker/php7/xdebug.ini /var/docker/php7/
COPY .docker/php7/cli/php.ini /var/docker/php7/cli/
COPY .docker/php7/fpm/php.ini /var/docker/php7/fpm/
COPY .docker/php7/fpm/www.conf /var/docker/php7/fpm/
COPY .docker/supervisor/supervisord.conf /etc/supervisor/conf.d/
COPY .docker/tools/cli-debug /usr/local/bin/
COPY .docker/etc/env.php /var/docker/etc/

# XDEBUG
ADD https://xdebug.org/files/xdebug-2.6.0.tgz /tmp/xdebug-2.6.0.tgz
RUN tar -C /var/local/ -xzf /tmp/xdebug-2.6.0.tgz
WORKDIR /var/local/xdebug-2.6.0
RUN phpize \
    && chmod u+x configure \
    && ./configure \
    && make \
    && cp /var/local/xdebug-2.6.0/modules/xdebug.so /usr/lib/php/20151012 \
    && touch /etc/php/7.1/mods-available/xdebug.ini \
    && ln -s /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/cli/conf.d/20-xdebug.ini \
    && ln -s /etc/php/7.1/mods-available/xdebug.ini /etc/php/7.1/fpm/conf.d/20-xdebug.ini \
    && rm /tmp/xdebug-2.6.0.tgz

# NODE, GRUNT
ADD https://nodejs.org/dist/v8.11.3/node-v8.11.3-linux-x64.tar.xz /tmp/node-v8.11.3-linux-x64.tar.xz
RUN unxz /tmp/node-v8.11.3-linux-x64.tar.xz \
    && tar -C /usr/local/ -xf /tmp/node-v8.11.3-linux-x64.tar \
    && rm /tmp/node-v8.11.3-linux-x64.tar \
    && export PATH=$PATH:/usr/local/node-v8.11.3-linux-x64/bin \
    && npm install -g grunt

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.1/fpm/php-fpm.conf

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
