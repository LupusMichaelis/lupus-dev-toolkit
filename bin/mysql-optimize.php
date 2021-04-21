<?php

main();

function main()
{
	mysqli_report(MYSQLI_REPORT_OFF);
	error_reporting(0);

	$dbcon = new mysqli
		( @$_ENV['DB_HOSTNAME']
		, @$_ENV['DB_USERNAME']
		, @$_ENV['DB_PASSWORD']
		, null
		, @$_ENV['DB_SOCKET']
		) and ! $dbcon->connect_errno
		or dief('Error connecting \'%s\'', $dbcon->connect_error);

	$bases = isset($_ENV['DB_BASENAME'])
		? [ $_ENV['DB_BASENAME'] ]
		: get_all_bases($dbcon)
		;

	$result = array_map
		( function($basename) use ($dbcon)
			{
				return optimize_base($dbcon, $basename);
			}
		, $bases
		);

	echo json_encode($result);
}

function get_all_bases(mysqli $dbcon)
{
	$databases = $dbcon->query('show databases')
		or dief('Error show databases \'%s\'', $dbcon->error);
	return array_column($databases->fetch_all(), 0);
}

function optimize_base(mysqli $dbcon, $basename)
{
	if(!$dbcon->select_db($basename))
		return json_die(['error' => sprintf('No database \'%s\'', $basename)]);

	$query = 'show tables';
	$tables = $dbcon->query($query)
		or dief('Error \'%s\', \'%s\'', $query, $dbcon->error);

	return array_map
		( function ($record) use($dbcon)
			{
				$table = $record[0];
				$sql_query = sprintf
					( 'optimize table `%s`'
					, $dbcon->real_escape_string($table)
					);
				$success = $dbcon->query($sql_query);
				if(! ($success instanceof mysqli_result))
					return compact
						( 'table'
						, 'sql_query'
						) +
						[ 'db_message' => $dbcon->error
						, 'file' => __FILE__
						, 'line' => __LINE__
						];

				$result = $success->fetch_all();

				return compact('table', 'sql_query', 'result');
			}
		, $tables->fetch_all()
		);
}

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
