#!/bin/bash
#phpMyAdmin By:liuwei Mail:al6008@163com
export MYSQL_HOST=${MYSQL_HOST:-"127.0.0.1"}

sed -i "s@localhost@${MYSQL_HOST}@g" /usr/local/nginx/html/config.inc.php

if [ ! -e "/etc/nginx/ssl/phpMyAdmin.crt" ];then
	mkdir -p /etc/nginx/ssl
	subject=/C=CN/ST=BeiJing/L=BeiJing/O=arxan/OU=Arxan_CA_liuwei/CN=Arxan_CA_liuwei/emailAddress=al6008@163.com
	openssl req -newkey rsa:4096 -nodes -sha256 -keyout /etc/nginx/ssl/phpMyAdmin.key -x509 -days 3650 -out /etc/nginx/ssl/phpMyAdmin.crt -subj ${subject}
fi

if [ ! -e "/etc/nginx/ssl/dhparam.pem" ];then
	mkdir -p /etc/nginx/ssl
	 openssl dhparam -out "/etc/nginx/ssl/dhparam.pem" 1024
fi

chown nginx:nginx -R /usr/local/nginx/

#停止服务
ps uax |grep nginx |grep -v grep |awk '{print $2}'|xargs kill &>/dev/null

#启动服务
if [ ! -e "/dev/shm/php-cgi.sock" ];then
	/etc/init.d/php-fpm start
else
	/etc/init.d/php-fpm restart
fi
sleep 3
/sbin/nginx
tail -f /var/log/nginx/error.log && exit 0
exit 1
