# tcdrupal-base

- Only meant for internal `drupal 7.34` development purposes only.

- The image is based on `CentOS 7` and includes `httpd 2.4.20` (ius repository), `php 5.4.45` (remi repository) with the following extensions `php-gd`, `php-mbstring`, `php-pdo`, `php-mysqlnd`, `php-xml` and `php-pecl-uploadprogress`.

- Since only for development the drupal source is not included within the image you will have to download it and mount it. 

#### Instructions:

`docker pull mariadb:10.0.26`

`docker pull thinkcube/tcdrupal-base`

`mkdir -p ~/tcdrupal/{mysql,drupal}`

`wget https://ftp.drupal.org/files/projects/drupal-7.34.tar.gz`

`tar xzvf --strip-components=1 drupal-7.34.tar.gz -C ~/tcdrupal/drupal`

`docker run --name mysql -v ~/tcdrupal/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=abc123 -e MYSQL_DATABASE=drupal -d mariadb:10.0.26`

`docker run --name drupal --link mysql:mysql -p 8081:80 -v ~/tcdrupal/drupal:/var/www/html -d thinkcube/tcdrupal-base`

`http://127.0.0.1:8081`

`Database name: drupal`

`Database user: root`

`Database password: abc123`

`Advanced Options:`

`Database host: mysql`
