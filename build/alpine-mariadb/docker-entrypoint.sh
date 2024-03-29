#!/bin/bash

[ -v DEBUG ] \
	&& set -x

function init()
{
	sql_tmp=$(mktemp)

    mysql_install_db \
		--skip-test-db \
		--user="${MYSQL_SYSUSER}" \
		--datadir="${MYSQL_DATA_PATH}" \
		--auth-root-socket-user="${MYSQL_SYSUSER}"

	echo "$@" \
		--datadir "${MYSQL_DATA_PATH}"

	"$@" \
		--datadir "${MYSQL_DATA_PATH}" \
		&

	pid="$!"

	sleep 2 # Wait for daemon to start up

	{
		if [ -n "$MYSQL_ROOT_PASSWORD" ]
		then
			echo "create user 'root'@'%' identified by '{$MYSQL_ROOT_PASSWORD}';"
			echo "create user '${MYSQL_SYSUSER}'@'%' identified by '${MYSQL_ROOT_PASSWORD}';"
			echo "create user '${LP_DEV_USER_ALIAS}'@'%' identified by '${MYSQL_ROOT_PASSWORD}';"
		fi

		if [ -f $INIT_DIR/credentials ]
		then
			echo "-- credentials --"
			echo "use \`mysql\`;"
			echo

			while IFS=';' read -r user host space table password
			do
				if [ "$table" != '*' ]
				then
					table="`$table`"
				fi

				# TABS must lead!!!
				cat <<- SQL
				create user if not exists '${user}'@'${host}' identified by '${password}';
				grant all privileges on \`${space}\`.${table} to '${user}'@'$host';
				SQL
			done < $INIT_DIR/credentials

			echo 'flush privileges;'
            echo
		fi

		if [ -d $INIT_DIR/schema ]
		then
			for schema in $(ls $INIT_DIR/schema/*.sql)
			do
				space=$(basename $schema .sql) # XXX Test not busybox
				echo "-- $schema --"
				echo "create database if not exists \`$space\`;"
				echo "use \`$space\`;"
				cat $schema
			done
            echo
		fi
	} | tee $sql_tmp | mysql

	test $? -ne 0 && echo "Error on data populating"

	kill -s TERM $pid
	wait $pid
}

init "$@"

exec "$@" \
	--datadir "${MYSQL_DATA_PATH}"
