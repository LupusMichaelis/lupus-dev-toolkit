#!/usr/bin/env bash

set -e

. "$LUPUSMICHAELIS_DIR/library.sh"

[[ ! -z "$DEBUG" ]] \
	&& set -x

lp-init()
{
	lp-assert-environement-is-set ANVIL
	lp-assert-environement-is-set UID
	lp-assert-environement-is-set USER_ALIAS

	id "${USER_ALIAS}" 2>&1 1>&/dev/null \
		|| adduser \
			--uid "${UID}" \
			--gecos '""' \
			--disabled-password \
			--home /home \
			"${USER_ALIAS}"

	mkdir -p "${ANVIL}"
	cd "${ANVIL}"

	echo \
		'export PS1="\w $ "'\
		> /home/.profile

	mkdir -p /home/bin
	chown -R dev /home
	export PATH="/home/bin:$PATH"

	# Initialize child docker containers
	for init in $(find "$LUPUSMICHAELIS_DOCKER_ENTRIES_DIR" -mindepth 1 -executable)
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
