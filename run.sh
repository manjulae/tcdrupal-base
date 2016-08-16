#!/bin/bash

export HOME=/home/user

/usr/local/bin/gosu root /bin/rm -f /var/run/httpd/httpd.pid

/usr/local/bin/gosu root /sbin/httpd -D NO_DETACH
