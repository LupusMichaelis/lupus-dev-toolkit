#!/usr/bin/env bash

set -e

[[ ! -z "$DEBUG" ]] \
	&& set -x

init()
{
}

main()
{
	init
	exec "$@"
}

main "$@"
