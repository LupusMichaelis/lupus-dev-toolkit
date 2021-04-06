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

	if [[ "disable" != "$LIGHTTPD_REWRITE" && "/index.php" != "$LIGHTTPD_TARGET" ]]
	then
		case "${LIGHTTPD_REWRITE}" in
        always)
            echo 'url.rewrite-once = ( "^.*$" => "'"$LIGHTTPD_TARGET"'" )'
            ;;
        when-not-found)
            echo 'url.rewrite-if-not-file = ( "^/.*$" => "'"$LIGHTTPD_TARGET"'" )'
            ;;
        esac > /etc/lighttpd/mod_rewrite.conf
	fi
}

main "$@"
