#!/usr/bin/env bash

set -e

[[ ! -z "$DEBUG" ]] \
	&& set -x

init()
{
	echo \
		'export PS1="\w $ "'\
		> /home/.profile

	mkdir -p /home/bin
	export PATH="/home/bin:$PATH"
}

main()
{
	init
	exec "$@"
}

main "$@"
