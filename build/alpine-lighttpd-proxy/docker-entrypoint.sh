#!/usr/bin/env bash

set -e

. "$LUPUSMICHAELIS_DIR/library.sh"

[[ ! -z "$DEBUG" ]] \
	&& set -x

main()
{
	lp-assert-environement-is-set BACKEND
}

main "$@"
