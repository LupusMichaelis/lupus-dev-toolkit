#!/usr/bin/env bash

set -e

[[ ! -z "$DEBUG" ]] \
	&& set -x

init()
{
	/usr/local/bin/composer-install.sh
}

main()
{
	init
	exec "$@"
}

main "$@"
