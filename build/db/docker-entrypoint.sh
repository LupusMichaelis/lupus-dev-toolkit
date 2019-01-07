#!/bin/sh

sql_tmp=$(mktemp)

cat << SQL > $sql_tmp
create user '${MYSQL_USER_NAME}'@'${MYSQL_USER_HOST}' identified by '${MYSQL_USER_PASSWORD}';
create database \`${MYSQL_USER_DATABASE}\`;
grant all privileges to '${MYSQL_USER_NAME}'@'${MYSQL_USER_HOST}' on \`${MYSQL_USER_DATABASE}\`.*;
flush privileges;
SQL

mysqld_safe --verbose=0 --bootstrap < $sql_tmp
rm -f $sql_tmp

exec mysqld_safe
