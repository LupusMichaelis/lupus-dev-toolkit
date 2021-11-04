#!/usr/bin/env bash

set -euo pipefail

[ -v DEBUG ] \
	&& set -x

. "$LUPUSMICHAELIS_DIR/library.sh"
. "$LUPUSMICHAELIS_DIR/lp-lighttpd.sh"


main()
{
	if [ "enable" = "$LIGHTTPD_SECURE" ]
	then
		lp-lighttpd-generate-tls
	fi

	if [ "enable" = "$LIGHTTPD_PROXY" ]
	then
		lp-assert-environement-is-set BACKEND
		lp-assert-environement-is-set BACKEND_DOCROOT
	fi

	local -a outputs=(
		/dev/fd/1
		/dev/fd/2
	)

	# We don't necessarly allocate a tty
	if [ -f /dev/pts/0 ]
	then
		outputs+=/dev/pts/0
	fi

	chown lighttpd:lighttpd ${outputs[@]}

	if [ -v DEBUG ]
	then
		echo 'include "debug.conf"' >> /etc/lighttpd/lighttpd.conf
	fi
}

main "$@"
