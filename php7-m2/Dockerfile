FROM debian:jessie

MAINTAINER VerdeAvis

ENV FASTCGI_TIMEOUT=1800 \
    PHP_MEMORY_LIMIT=512M \
    XDEBUG_REMOTE_PORT=9000

RUN DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y curl \
    && echo "deb http://packages.dotdeb.org jessie all" > /etc/apt/sources.list.d/dotdeb.list \
    && curl -sS https://www.dotdeb.org/dotdeb.gpg | apt-key add - \
    && sed -i "s/httpredir.debian.org/`curl -s -D - http://httpredir.debian.org/demo/debian/ | awk '/^Link:/ { print $2 }' | sed -e 's@<http://\(.*\)/debian/>;@\1@g'`/" /etc/apt/sources.list \
    && apt-get clean && apt-get update \
    && apt-get -y --no-install-recommends install xz-utils cron nginx inetutils-ping supervisor dnsutils make vim git ssh \
      mysql-client redis-tools php7.0 php7.0-fpm php7.0-dev php7.0-curl php7.0-gd php7.0-intl php7.0-json \
      php7.0-phpdbg php7.0-redis php7.0-mysql php7.0-cli php7.0-mcrypt php7.0-opcache php7.0-readline php7.0-apcu \
      php7.0-zip php7.0-apcu-bc php7.0-xsl php7.0-mbstring \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Dockerize
RUN curl -L https://github.com/jwilder/dockerize/releases/download/v0.0.2/dockerize-linux-amd64-v0.0.2.tar.gz -o dockerize.tgz \
    && tar -C /usr/local/bin -xzf dockerize.tgz \
    && rm dockerize.tgz

# Dockerized files needs to be moved to TMP dir.
COPY .docker/nginx/nginx.conf /tmp/
COPY .docker/nginx/default.conf /tmp/
COPY .docker/php7/xdebug.ini /tmp/
COPY .docker/php7/php.ini /tmp/

RUN dockerize -template=/tmp/nginx.conf:/etc/nginx/nginx.conf /bin/true \
    && dockerize -template=/tmp/default.conf:/etc/nginx/conf.d/default.conf /bin/true \
    && dockerize -template=/tmp/php.ini:/etc/php/7.0/fpm/php.ini /bin/true
COPY .docker/supervisor/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY .docker/run.sh /var/run.sh
COPY .docker/tools/* /usr/local/bin/

# XDEBUG
WORKDIR /root/
RUN curl -L https://xdebug.org/files/xdebug-2.5.3.tgz -o xdebug-2.5.3.tgz \
    && tar -C /var/local/ -xzf xdebug-2.5.3.tgz
WORKDIR /var/local/xdebug-2.5.3
RUN phpize
RUN chmod u+x /var/local/xdebug-2.5.3/configure
WORKDIR /var/local/xdebug-2.5.3/
RUN ./configure
WORKDIR /var/local/xdebug-2.5.3/
RUN make \
    && cp /var/local/xdebug-2.5.3/modules/xdebug.so /usr/lib/php/20151012 \
    && mkdir -p /etc/php/mods-available/ \
    && dockerize -template=/tmp/xdebug.ini:/etc/php/mods-available/xdebug.ini /bin/true \
    && ln -s /etc/php/mods-available/xdebug.ini /etc/php/7.0/fpm/conf.d/20-xdebug.ini \
    && ln -s /etc/php/mods-available/xdebug.ini /etc/php/7.0/cli/conf.d/20-xdebug.ini \
    && rm -rf /root/xdebug-2.5.3.tgz \
    && rm /tmp/*.conf /tmp/*.ini

# NODE, GRUNT
workdir /root/
RUN curl -L https://nodejs.org/dist/v6.10.3/node-v6.10.3-linux-x64.tar.xz -o node-v6.10.3-linux-x64.tar.xz \
    && unxz node-v6.10.3-linux-x64.tar.xz \
    && tar -C /usr/local/ -xf node-v6.10.3-linux-x64.tar \
    && rm node-v6.10.3-linux-x64.tar \
    && export PATH=$PATH:/usr/local/node-v6.10.3-linux-x64/bin \
    && npm install -g grunt

RUN sed -i -e "s/;daemonize\s*=\s*yes/daemonize = no/g" /etc/php/7.0/fpm/php-fpm.conf

RUN mkdir -p /run/php \
    && chmod 777 /var/run.sh \
    && usermod -u 1000 www-data \
    && chsh -s /bin/bash www-data \
    && mkdir -p /var/www/current \
    && chown www-data:www-data -R /var/www

ADD https://getcomposer.org/composer.phar /usr/bin/composer
RUN chmod +rx /usr/bin/composer

RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80 80
WORKDIR /var/www/current
CMD ["/var/run.sh"]
