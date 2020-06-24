#!/usr/bin/env bash

lp-die()
{
	readonly msg="Die: '$1'"

	if [[ -z "$2" ]]
	then
		readonly code=1
	else
		readonly code=$2
	fi

	echo >&2 "$msg"
	exit "$code"
}
