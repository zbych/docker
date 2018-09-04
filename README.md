# Docker Images ready for running either Magento and Magento2 #

### Container sets:
 - Magento 1.x with PHP5
 - Magento 1.x with PHP7
 - Magento 2.x with PHP7
 - Magento 2.x with PHP7.1
 - WordPress with PHP7.2
 
### Utilizes
 - docker-compose v3
 - Percona
 - Mysql
 - Redis

### Web Images supports:
 - Nginx/PHP-FPM
 - Node (npm)
 - Composer
 - Xdebug (even in PHP7)

### How to use?
 - `docker-project-init container_name project` 
 - Adjust .env file and docker-compose.yml if needed
 - Run `sudo docker-compose up`
