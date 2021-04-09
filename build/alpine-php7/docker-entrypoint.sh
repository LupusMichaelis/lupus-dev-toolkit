#!/usr/bin/env bash

set -e

[ -v DEBUG ] \
	&& set -x

. "$LUPUSMICHAELIS_DIR/library.sh"

main()
{
	lp-assert-environement-is-set ANVIL
	lp-assert-environement-is-set LP_DEV_UID
	lp-assert-environement-is-set LP_DEV_USER_ALIAS

	mkdir -p "$ANVIL/public"
	mkdir -p /var/log/php7
	chown "$LP_DEV_UID" \
		/var/log/php7 \
		"$ANVIL/public"

	if [ 'enable' = "$PHP_FPM" ]
	then
		exec /usr/sbin/php-fpm7 --nodaemonize
	elif [ 'enable' = "$PHP_COMPOSER" ]
	then
		exec composer "$@"
	else
		exec "$@"
	fi
}

main "$@"
