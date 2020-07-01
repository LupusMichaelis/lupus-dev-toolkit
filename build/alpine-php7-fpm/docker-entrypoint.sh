#!/usr/bin/env bash

set -e

. "$LUPUSMICHAELIS_DIR/library.sh"

[[ ! -z "$DEBUG" ]] \
	&& set -x

main()
{
	lp-assert-environement-is-set ANVIL
	lp-assert-environement-is-set UID
	lp-assert-environement-is-set USER_ALIAS

	mkdir -p "$ANVIL/public"
	chown "$UID" \
		/var/log/php7/ \
		"$ANVIL/public"
}

main "$@"
