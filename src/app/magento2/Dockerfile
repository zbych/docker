ARG MAGERUN_VERSION

# Magerun
ADD https://files.magerun.net/n98-magerun$MAGERUN_VERSION.phar /usr/local/bin/magerun

# Configure Magento2:
RUN mkdir /var/docker/etc -p
COPY .docker/etc/env.php /var/docker/etc/
