#!/bin/bash

function init()
{
	sql_tmp=$(mktemp)

	echo "$@" \
		--datadir "${MYSQL_DATA_PATH}" \

	"$@" \
		--datadir "${MYSQL_DATA_PATH}" \
		&

	pid="$!"

	sleep 2 # Wait for daemon to start up

	{
		if [ -n "$MYSQL_ROOT_PASSWORD" ]
		then
			echo "alter user 'root'@'%' identified by '$MYSQL_ROOT_PASSWORD';"
		fi

		if [ -d $INIT_DIR/schema ]
		then
			for schema in $(ls $INIT_DIR/schema/*.sql)
			do
				space=$(basename $schema .sql) # XXX Test not busybox
				echo "create database \`$space\`;"
				echo "use \`$space\`;"
				cat $schema
			done
		fi

		if [ -f $INIT_DIR/credentials ]
		then
			while IFS=';' read -r user host space table password
			do
				if [ "$table" != '*' ]
				then
					table="`$table`"
				fi

				# TABS must lead!!!
				cat <<- SQL
				create user '${user}'@'${host}' identified by '${password}';
				grant all privileges on \`${space}\`.${table} to '${user}'@'$host';
				SQL
			done < $INIT_DIR/credentials

			echo 'flush privileges;'
		fi
	} | tee $sql_tmp | mysql

	test $? -ne 0 && echo "Error on data populating"

	kill -s TERM $pid
	wait $pid
}

init "$@"

exec "$@" \
	--datadir "${MYSQL_DATA_PATH}"
