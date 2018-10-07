#!/bin/bash

cd /tmp
curl -O https://raw.githubusercontent.com/minh10huy/gammu-smsdrc/master/mysql.sql
mysql -uroot -ppassw0rd <<MYSQL_SCRIPT
USE smsdb;
GRANT ALL PRIVILEGES ON *.* TO 'smsd'@'localhost';
FLUSH PRIVILEGES;
QUIT
MYSQL_SCRIPT

mysql -uroot -ppassw0rd smsdb < mysql.sql
rm -rf mysql.sql

exit 0
