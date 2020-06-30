#!/usr/bin/env bash

set -e

. "$LUPUSMICHAELIS_DIR/library.sh"

[[ ! -z "$DEBUG" ]] \
	&& set -x

lp-init()
{
	# XXX Check UID USER_ALIAS

	adduser \
		-u ${UID} \
		-g "" \
		-D \
		-h /home \
		${USER_ALIAS}

	mkdir -p ${ANVIL}

	echo \
		'export PS1="\w $ "'\
		> /home/.profile

	mkdir -p /home/bin
	export PATH="/home/bin:$PATH"

	# Initialize child docker containers
	for init in $(find "$LUPUSMICHAELIS_DOCKER_ENTRIES_DIR" -executable -mindepth 1)
	do
		$init
	done
}

main()
{
	lp-init

	exec gosu $USER_ALIAS "$@"
}

main "$@"
