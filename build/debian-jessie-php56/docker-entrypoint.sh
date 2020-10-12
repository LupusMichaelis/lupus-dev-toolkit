#!/usr/bin/env bash

set -e

[[ ! -z "$DEBUG" ]] \
	&& set -x

init()
{
	composer-install.sh
}

main()
{
	init
	exec "$@"
}

main "$@"
