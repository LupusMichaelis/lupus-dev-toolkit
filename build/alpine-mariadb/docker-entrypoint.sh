#!/bin/sh

sql_tmp=$(mktemp)

cat << SQL > $sql_tmp
create user '${MYSQL_USER_NAME}'@'%' identified by '${MYSQL_USER_PASSWORD}';
create user '${MYSQL_USER_NAME}'@'localhost' identified by '${MYSQL_USER_PASSWORD}';
create database ${MYSQL_USER_DATABASE};
grant all privileges on ${MYSQL_USER_DATABASE}.* to '${MYSQL_USER_NAME}'@'%';
grant all privileges on ${MYSQL_USER_DATABASE}.* to '${MYSQL_USER_NAME}'@'localhost';
flush privileges;
SQL

mysqld &
pid="$!"

sleep 2 # Wait for daemon to start up

cat $sql_tmp | mysql -uroot

kill -s TERM $pid
wait $pid

exec "$@" \
    --datadir "${MYSQL_DATA_PATH}" \

