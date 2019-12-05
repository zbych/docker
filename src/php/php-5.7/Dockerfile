FROM debian:jessie

ARG SHARED_UID
ARG NODE_VERSION
ARG BLACKFIRE_ENABLED
ENV PHP_VERSION "5.7"

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get -y --no-install-recommends install xz-utils cron curl nginx inetutils-ping supervisor dnsutils make vim \
        git ssh mysql-client redis-tools php5 php5-fpm php5-dev php5-curl php5-gd php5-intl php5-json php5-phpdbg \
        php5-redis php5-mysql php5-cli php5-mcrypt php5-apcu php-apc php5-readline php5-apcu php-pclzip php5-xsl \
        php5-xdebug php5-bcmath bzip2 wget apt-transport-https lsb-release ca-certificates unzip openssl patch \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Dockerized files needs to be moved to TMP dir.
RUN mkdir /var/docker/ \
    && mkdir /var/docker/php \
    && mkdir /var/docker/php/cli \
    && mkdir /var/docker/php/fpm

# Copy environment files;
COPY .docker/php/xdebug.ini /var/docker/php/
COPY .docker/php/cli/* /var/docker/php/cli/
COPY .docker/php/fpm/* /var/docker/php/fpm/

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php5/fpm/php-fpm.conf

# Redirect logs:
RUN ln -sf /dev/stderr /var/log/php5-fpm.log
