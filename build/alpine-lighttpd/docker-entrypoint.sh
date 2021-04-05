#!/usr/bin/env bash

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
}

main "$@"
