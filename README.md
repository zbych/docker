# Docker based Magento Fast Environment #

### Container sets:
 - Magento 1.x with PHP5
 - Magento 1.x with PHP7
 - Magento 2.x with PHP7
 - Magento 2.x with PHP7.1
 - WordPress with PHP7.2
 
### Utilizes
 - docker-compose v3
 - MySQL (Percona)
 - Redis
 - Mailcatcher with Mailhog

### Web Images supports:
 - Nginx/PHP-FPM
 - Node (npm)
 - Composer
 - Xdebug (even in PHP7)

### How to use?
 - Clone your working copy of Magento or Magento2
 - `docker-project-init container_name project` 
 - Adjust .env file if needed
 - Run `sudo docker-compose up`
 - Enjoy
