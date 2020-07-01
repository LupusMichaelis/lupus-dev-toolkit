#!/usr/bin/env bash

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
