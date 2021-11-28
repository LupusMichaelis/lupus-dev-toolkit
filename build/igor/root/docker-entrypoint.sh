#!/usr/bin/env bash

set -euo pipefail

[ -v DEBUG ] \
	&& set -x || set +x

. "$LUPUSMICHAELIS_DIR/library.sh"

lp-distribution-get()
{
	lupusmichaelis-deprecated "${FUNCNAME[0]}"
	lupusmichaelis-distribution-get "$@"
}

lp-init()
{
	lupusmichaelis-deprecated "${FUNCNAME[0]}"
	lupusmichaelis-init "$@"
}

lp-set-dev-user()
{
	lupusmichaelis-deprecated "${FUNCNAME[0]}"
	lupusmichaelis-set-dev-user "$@"
}

lupusmichaelis-distribution-get()
{
	. /etc/os-release
	echo "$ID"
}

lupusmichaelis-init()
{
	lupusmichaelis-assert-environement-is-set ANVIL

	[ -v LUPUSMICHAELIS_DEV_USER_ALIAS ] && lupusmichaelis-set-dev-user

	mkdir -p "${ANVIL}"
	cd "${ANVIL}"

	mkdir -p /home/bin
	export PATH="/home/bin:$PATH"

	# Initialize child docker containers
	for init in $(find "$LUPUSMICHAELIS_DOCKER_ENTRIES_DIR" -mindepth 1 -executable)
	do
		$init
		if [ ! "$?" ]
		then
			lupusmichaelis-die "Docker entrypoint '$ini' failed"
		fi
	done
}

lupusmichaelis-set-dev-user()
{
	lupusmichaelis-assert-environement-is-set LUPUSMICHAELIS_DEV_UID
	lupusmichaelis-assert-environement-is-set LUPUSMICHAELIS_DEV_USER_ALIAS

	case "$(lupusmichaelis-distribution-get)" in
		debian)
			id "${LUPUSMICHAELIS_DEV_USER_ALIAS}" 2>&1 1>&/dev/null \
				|| adduser \
					--uid "${LUPUSMICHAELIS_DEV_UID}" \
					--gecos '""' \
					--disabled-password \
					--home /home \
					"${LUPUSMICHAELIS_DEV_USER_ALIAS}"
		;;
		alpine)
			id "${LUPUSMICHAELIS_DEV_USER_ALIAS}" 2>&1 1>&/dev/null \
				|| adduser \
					-u "$LUPUSMICHAELIS_DEV_UID" \
					-g "" \
					-D \
					-h /home \
					"${LUPUSMICHAELIS_DEV_USER_ALIAS}"
		;;
		*)
			lupusmichaelis-die "Unsupported distribution '$OS'"
		;;
	esac

	echo \
		'export PS1="\w $ "'\
		> /home/.profile

	chown -R "${LUPUSMICHAELIS_DEV_USER_ALIAS}" /home
}

main()
{
	lupusmichaelis-init

	if [ -v LUPUSMICHAELIS_DEV_USER_ALIAS ]
	then
		exec gosu "$LUPUSMICHAELIS_DEV_USER_ALIAS" "$@"
	else
		exec "$@"
	fi
}

main "$@"
