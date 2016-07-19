#only ment for develpoment
FROM centos:7
MAINTAINER manjula@thinkcube.com

WORKDIR /root

RUN yum install epel-release -y

RUN yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm -y

RUN yum install https://centos7.iuscommunity.org/ius-release.rpm -y

RUN sed -i  "0,/enabled=0/{s/enabled=0/enabled=1/}" /etc/yum.repos.d/remi.repo

#install apache 2.4.20 from ius repo
RUN yum install httpd24u -y

#RUN echo "Include vhost.d/*.conf" >> /etc/httpd/conf/httpd.conf

#RUN mkdir /etc/httpd/vhost.d

RUN sed -i 's/^\([^#]\)/#\1/g' /etc/httpd/conf.d/welcome.conf

#install php 5.4.45 from remi repo
RUN yum install php php-gd php-mbstring php-pdo php-mysqlnd -y

RUN sed -i "s|;date.timezone =|date.timezone = Asia/Colombo|" /etc/php.ini

RUN yum clean all

VOLUME /etc/httpd/conf.d

VOLUME /var/www/html

EXPOSE 80
