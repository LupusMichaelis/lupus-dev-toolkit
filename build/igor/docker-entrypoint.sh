#!/usr/bin/env bash

set -e

. "$LUPUSMICHAELIS_DIR/library.sh"

[ -v DEBUG ] \
	&& set -x

lp-distribution-get()
{
	. /etc/os-release
	echo "$ID"
}

lp-init()
{
	lp-assert-environement-is-set ANVIL

	[ -v LP_DEV_USER_ALIAS ] && lp-set-dev-user

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
			lp-die "Docker entrypoint '$ini' failed"
		fi
	done
}

lp-set-dev-user()
{
	lp-assert-environement-is-set LP_DEV_UID
	lp-assert-environement-is-set LP_DEV_USER_ALIAS

	case "$(lp-distribution-get)" in
		debian)
			id "${LP_DEV_USER_ALIAS}" 2>&1 1>&/dev/null \
				|| adduser \
					--uid "${LP_DEV_UID}" \
					--gecos '""' \
					--disabled-password \
					--home /home \
					"${LP_DEV_USER_ALIAS}"
		;;
		alpine)
			id "${LP_DEV_USER_ALIAS}" 2>&1 1>&/dev/null \
				|| adduser \
					-u "$LP_DEV_UID" \
					-g "" \
					-D \
					-h /home \
					"${LP_DEV_USER_ALIAS}"
		;;
		*)
			lp-die "Unsupported distribution '$OS'"
		;;
	esac

	echo \
		'export PS1="\w $ "'\
		> /home/.profile

	chown -R "${LP_DEV_USER_ALIAS}" /home
}

main()
{
	lp-init

	if [ -v LP_DEV_USER_ALIAS ]
	then
		exec gosu "$LP_DEV_USER_ALIAS" "$@"
	else
		exec "$@"
	fi
}

main "$@"
