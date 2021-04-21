<?php

function dief()
{
	$args = func_get_args();
	$fmt = array_shift($args);
	vfprintf(STDERR, $fmt, $args);
	die("\n");
}

function die_json($payload)
{
	dief(json_encode($payload));
}

mysqli_report(MYSQLI_REPORT_OFF);

$dbcon = new mysqli
	( @$_ENV['DB_HOSTNAME']
	, @$_ENV['DB_USERNAME']
	, @$_ENV['DB_PASSWORD']
	, @$_ENV['DB_BASENAME']
	, @$_ENV['DB_SOCKET']
	) and ! $dbcon->connect_errno
	or dief('Error connecting \'%s\'', $dbcon->connect_error);

$tables = $dbcon->query('show tables')
	or dief('Error show query \'%s\'', $dbcon->error);

$result = array_map
	( function ($record) use($dbcon)
		{
			$table = $record[0];
			$sql_query = sprintf
				( 'optimize table `%s`'
				, $dbcon->real_escape_string($table)
				);
			$success = $dbcon->query($sql_query);
			if(! ($success instanceof mysqli_result))
				die_json
					(
						compact('sql_query') +
						[ 'db_message' => $dbcon->error
						, 'file' => __FILE__
						, 'line' => __LINE__
						]
					);

			$result = $success->fetch_all();

			return compact('table', 'sql_query', 'result');
		}
	, $tables->fetch_all()
	);

echo json_encode($result);
