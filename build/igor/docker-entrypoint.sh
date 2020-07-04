#!/usr/bin/env bash

set -e

. "$LUPUSMICHAELIS_DIR/library.sh"

[[ ! -z "$DEBUG" ]] \
	&& set -x

lp-distribution-get()
{
	. /etc/os-release
	echo "$ID"
}

lp-init()
{
	lp-assert-environement-is-set ANVIL
	lp-assert-environement-is-set UID
	lp-assert-environement-is-set USER_ALIAS

	case "$(lp-distribution-get)" in
		debian)
			id "${USER_ALIAS}" 2>&1 1>&/dev/null \
				|| adduser \
					--uid "${UID}" \
					--gecos '""' \
					--disabled-password \
					--home /home \
					"${USER_ALIAS}"
		;;
		alpine)
			id "${USER_ALIAS}" 2>&1 1>&/dev/null \
				|| adduser \
					-u "$UID" \
					-g "" \
					-D \
					-h /home \
					"${USER_ALIAS}"
		;;
		*)
			lp-die "Unsupported distribution '$OS'"
		;;
	esac

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
