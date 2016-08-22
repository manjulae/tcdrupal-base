#!/bin/bash

export HOME=/home/user

/usr/local/bin/gosu root /bin/chmod 750 /var/run/httpd/
/usr/local/bin/gosu root /bin/chmod 750 /run/httpd/
/usr/local/bin/gosu root /bin/rm -rf /var/run/httpd/* /run/httpd/* /tmp/httpd*

/usr/local/bin/gosu root /sbin/httpd -D FOREGROUND
