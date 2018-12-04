# Magerun
ADD https://files.magerun.net/n98-magerun.phar /usr/local/bin/magerun
RUN chmod +rx /usr/local/bin/magerun

# Configure Magento
RUN mkdir /var/docker/etc -p
COPY .docker/etc/local.xml /var/docker/etc/
