#!/usr/bin/env bash

lp-assert-environement-is-set()
{
	local -r name="$1"

	[ -z "${name}" ] \
		&& lp-die "Anonymous environment variable"

	[ -z "${!name}" ] \
		&& lp-die "Environment '$name' is not set"

	echo -n
}

lp-die()
{
	local -r msg="Die: '$1'"

	if [ -z "$2" ]
	then
		local -r code=1
	else
		local -r code=$2
	fi

	echo >&2 "$msg"
	exit "$code"
}
