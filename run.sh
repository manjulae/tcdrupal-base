#!/bin/bash

if [[ -f /var/www/html/index.php ]];
  then
    chown -R apache:apache /var/www/html/*
fi

/sbin/httpd -D NO_DETACH
