#!/bin/bash

export HOME=/home/user

/usr/local/bin/gosu root rm -f /run/httpd/httpd.pid

/usr/local/bin/gosu root /sbin/httpd -D NO_DETACH
