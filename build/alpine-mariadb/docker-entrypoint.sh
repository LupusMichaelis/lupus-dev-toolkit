#!/bin/sh

sql_tmp=$(mktemp)

cat << SQL > $sql_tmp
create database ${MYSQL_USER_DATABASE};
create user '${MYSQL_USER_NAME}'@'%' identified by '${MYSQL_USER_PASSWORD}';
grant all privileges on ${MYSQL_USER_DATABASE}.* to '${MYSQL_USER_NAME}'@'%';
flush privileges;
SQL

mysqld \
    --datadir "${MYSQL_DATA_PATH}" \
    &

pid="$!"

sleep 2 # Wait for daemon to start up

cat $sql_tmp | mysql -uroot mysql

kill -s TERM $pid
wait $pid

exec "$@" \
    --datadir "${MYSQL_DATA_PATH}" \

