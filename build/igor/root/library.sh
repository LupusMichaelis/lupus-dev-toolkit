#!/usr/bin/env bash

set -euo pipefail

[ -v DEBUG ] \
	&& set -x || set +x

lp-assert-environement-is-set()
{
	lupusmichaelis-deprecated "${FUNCNAME[0]}"
	lupusmichaelis-assert-environement-is-set "$@"
}

lp-die()
{
	lupusmichaelis-deprecated "${FUNCNAME[0]}"
	lupusmichaelis-die "$@"
}

lupusmichaelis-deprecated()
{
	printf "Function '%s' is deprecated\n" "$1"
}

lupusmichaelis-assert-environement-is-set()
{
	local -r name="$1"

	[ -z "${name}" ] \
		&& lupusmichaelis-die "Anonymous environment variable"

	[ ! -v $name ] \
		&& lupusmichaelis-die "Environment '$name' is not set"

	echo -n
}

lupusmichaelis-die()
{
	if (( 1 == $# ))
	then
		local -r code=1
	else
		local -r code=$2
	fi

	printf >&2 "Die: '%b'\n" "$1"
	exit $code
}
