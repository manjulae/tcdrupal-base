#!/bin/bash

if [[ ! -f /var/www/html/index.php ]];
  then
    cp -r /usr/src/drupal-7.34/* /var/www/html
    chown -R apache:apache /var/www/html/*
    rm -rf /usr/src/drupal-7.34
fi

/sbin/httpd -D NO_DETACH
