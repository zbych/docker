# Docker based Fast Web Application Environment #
Tailored for Debian based distributions.

### Requirements:
* Linux based systems (Debian)
* Docker: 18.x or higher
* docker-compose: 1.23
* Binaries: awk, sed, ifconfig, git
* Released ports: 3306 (mysql), 80 (apache,nginx), 6379 (redis), 8025 (mailhog)

### Available Variations:
 - Magento 1.x with PHP5.6, PHP7.0, PHP7.1, PHP.7.2, PHP.7.3
 - Magento 2.x with PHP5.6, PHP7.0, PHP7.1, PHP.7.2, PHP.7.3
 - WordPress with PHP5.6, PHP7.0, PHP7.1, PHP.7.2, PHP.7.3
 - Symfony with PHP5.6, PHP7.0, PHP7.1, PHP.7.2, PHP.7.3
 
### Containers
 - Web (application)
 - MySQL
 - Redis
 - MailHog
 - BlackFire

### Web Image supports:
 - nginx
 - PHP-FPM
 - Node, npm
 - Composer
 - Xdebug (even for php7.0, Xdebug 3.x)
 - BlackFire
 - n98-magerun

### INSTALL
`curl -sSL https://raw.githubusercontent.com/zbych/docker/master/install.sh | bash`

### How to use?
 1. Clone your working copy of Application from Github
 2. `docker-project-init <platform> <application> <name> [<reliative path to application root>]` 
 3. Adjust .env file if needed and docker-compose.yml
 4. Run `sudo docker-compose up`
 5. Enter to container `sudo docker-compose exec web`
 6. Switch to www-data user: `su www-data`
 7. Enjoy
 
### Platforms:
 - php-5.6
 - php-7.0
 - php-7.1
 - php-7.2
 - php-7.3
 - php-7.4
 
### Applications
 - magento
 - magento2
 - symfony
 - wp
