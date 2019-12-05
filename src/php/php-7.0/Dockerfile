FROM debian:stretch

ARG SHARED_UID
ARG NODE_VERSION
ARG BLACKFIRE_ENABLED
ENV PHP_VERSION "7.0"

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get clean && apt-get update \
    && apt-get -y --no-install-recommends install curl xz-utils cron nginx nginx-common nginx-extras inetutils-ping \
      supervisor dnsutils make vim git ssh mysql-client redis-tools php7.0 php7.0-fpm php7.0-dev php7.0-curl php7.0-gd \
      php7.0-intl php7.0-json php7.0-soap php7.0-phpdbg php7.0-redis php7.0-mysql php7.0-cli php7.0-mcrypt \
      php7.0-opcache  php7.0-readline php7.0-memcached php7.0-zip php7.0-xsl php7.0-mbstring php7.0-bcmath \
      apt-transport-https lsb-release wget ca-certificates bzip2 unzip openssl patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*\
    && update-ca-certificates

# Create mandatory paths:
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php \
    && mkdir /var/docker/php/fpm \
    && mkdir /var/docker/php/cli

# Copy templates to Image:
COPY .docker/php/xdebug.ini /var/docker/php/
COPY .docker/php/cli/* /var/docker/php/cli/
COPY .docker/php/fpm/* /var/docker/php/fpm/

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

# Increase Opcache Limit:
RUN echo "opcache.memory_consumption=256" >> /etc/php/7.0/mods-available/opcache.ini

# Curl
ADD https://curl.haxx.se/ca/cacert.pem /var/www

# XDEBUG
ADD https://xdebug.org/files/xdebug-2.8.0.tgz /tmp/xdebug-2.8.0.tgz
RUN tar -C /var/local/ -xzf /tmp/xdebug-2.8.0.tgz
WORKDIR /var/local/xdebug-2.8.0
RUN phpize \
    && chmod u+x configure \
    && ./configure \
    && make \
    && cp /var/local/xdebug-2.8.0/modules/xdebug.so $(php-config --extension-dir) \
    && touch /etc/php/7.0/mods-available/xdebug.ini \
    && ln -s /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini \
    && ln -s /etc/php/7.0/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini \
    && rm /tmp/xdebug-2.8.0.tgz

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php7.0-fpm.log
