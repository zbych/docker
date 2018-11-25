FROM debian:jessie
ARG SHARED_UID

MAINTAINER Zbigniew Łabacz <zbigniew.labacz@gmail.com>

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl wget apt-transport-https lsb-release ca-certificates \
    && wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg \
    && sh -c 'echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list'

RUN apt-get update \
    && apt-get -y --no-install-recommends install xz-utils cron nginx inetutils-ping supervisor dnsutils make vim git ssh g++ \
      mysql-client redis-tools php7.2 php7.2-common php7.2-fpm php7.2-dev php7.2-curl php7.2-gd php7.2-intl php7.2-json php7.2-soap \
      php7.2-phpdbg php7.2-mysql php7.2-cli php7.2-opcache php7.2-zip php7.2-xsl php7.2-mbstring bzip2 \
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
ADD https://xdebug.org/files/xdebug-2.6.0.tgz /tmp/xdebug-2.6.0.tgz
RUN tar -C /var/local/ -xzf /tmp/xdebug-2.6.0.tgz
WORKDIR /var/local/xdebug-2.6.0
RUN phpize \
    && chmod u+x configure \
    && ./configure \
    && make \
    && cp /var/local/xdebug-2.6.0/modules/xdebug.so /usr/lib/php/20170718 \
    && touch /etc/php/7.2/mods-available/xdebug.ini \
    && ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/cli/conf.d/20-xdebug.ini \
    && ln -s /etc/php/7.2/mods-available/xdebug.ini /etc/php/7.2/fpm/conf.d/20-xdebug.ini \
    && rm /tmp/xdebug-2.6.0.tgz

# NODE, GULP
ADD https://nodejs.org/dist/v8.11.4/node-v8.11.4-linux-x64.tar.xz /tmp/node-v8.11.4-linux-x64.tar.xz
RUN unxz /tmp/node-v8.11.4-linux-x64.tar.xz \
    && tar -C /usr/local/ -xf /tmp/node-v8.11.4-linux-x64.tar \
    && rm /tmp/node-v8.11.4-linux-x64.tar \
    && export PATH=$PATH:/usr/local/node-v8.11.4-linux-x64/bin

# Set PHP-FPM running as non-daemon
RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.2/fpm/php-fpm.conf

RUN mkdir -p /run/php \
    && chmod 777 /var/docker/run.sh \
    && usermod -u $SHARED_UID www-data \
    && chsh -s /bin/bash www-data \
    && mkdir -p /var/www/current \
    && chown www-data:www-data -R /var/www

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 80
WORKDIR /var/www/current
CMD ["/var/docker/run.sh"]
