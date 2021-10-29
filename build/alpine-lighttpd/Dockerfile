# syntax=docker/dockerfile-upstream:master-labs
FROM lupusmichaelis/alpine:1.0.1
LABEL description="Alpine Linux with Lighttpd"

USER 0

RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            ca-certificates \
            lighttpd \
            openssl \
        && echo Apk done

RUN mkdir -p /var/run/lighttpd
RUN chown lighttpd:lighttpd /var/run/lighttpd /dev/fd/1 /dev/fd/2

RUN sed -i \
    -e '/^# server\.port          = 81/s/^.*$/server.port = 80/' \
    -e '/^# server\.bind          = 81/s/^.*$/server.bind = 0.0.0.0/' \
    -e 's@/run/lighttpd.pid@/run/lighttpd/lighttpd.pid@' \
	-e 's@^server\.errorlog.*$@server.errorlog = "/dev/fd/2"@' \
	-e 's@^accesslog\.filename.*@accesslog.filename = "/dev/fd/1"@' \
    /etc/lighttpd/lighttpd.conf

COPY docker-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh

COPY mod_fastcgi.conf debug.conf /etc/lighttpd/

WORKDIR "/var/www/localhost/htdocs"

COPY library.sh ${LUPUSMICHAELIS_DIR}/lp-lighttpd.sh

ARG LIGHTTPD_PROXY=disable
ENV LIGHTTPD_PROXY=${LIGHTTPD_PROXY}
RUN if [ "${LIGHTTPD_PROXY}" = 'enable' ]; \
    then \
        sed -i \
            -e '/include "mod_fastcgi.conf"/s/#//' \
            -e 's#\#.*mod_alias.*,.*#    "mod_alias",#g' \
            /etc/lighttpd/lighttpd.conf; \
        echo -n "<?php #Lighttpd needs this file to exist to consider it as an index candidate" \
        > "index.php"; \
    fi;

ARG LIGHTTPD_SECURE=disable
ENV LIGHTTPD_SECURE=${LIGHTTPD_SECURE}
RUN if [ "${LIGHTTPD_SECURE}" = 'enable' ]; \
    then \
        sed -i \
            -e '/^server\.port = 80/s/^.*$/server.port = 443/' \
            -e '/^# ssl\.engine    = "enable"/s/^.*$/ssl.engine = "enable"/' \
            -e '/^# ssl\.pemfile   = "server.pem"/s/^.*$/ssl.pemfile = "\/etc\/lighttpd\/server.pem"/' \
            -e '/server\.modules = (/a     "mod_openssl",' \
            /etc/lighttpd/lighttpd.conf; \
    fi

ARG LIGHTTPD_REWRITE=disable
ENV LIGHTTPD_REWRITE=${LIGHTTPD_REWRITE}
ARG LIGHTTPD_TARGET=/index.php
ENV LIGHTTPD_TARGET=${LIGHTTPD_TARGET}
RUN <<eos
#!/bin/bash

set -euo pipefail

case "${LIGHTTPD_REWRITE}" in
	always)
		cat <<- eoc
		url.rewrite-once = (
			"^.*$" => "$LIGHTTPD_TARGET"
			)
		eoc
		;;
	when-not-found)
		cat <<- eoc
		url.rewrite-if-not-file = (
			"^.*$" => "$LIGHTTPD_TARGET"
		)
		eoc
		;;
	esac > /etc/lighttpd/mod_rewrite.conf

sed -i \
	-e '/"mod_rewrite"/s/#//' \
	/etc/lighttpd/lighttpd.conf

echo 'include "mod_rewrite.conf"' >> /etc/lighttpd/lighttpd.conf

eos

COPY security-header.conf /etc/lighttpd/security-header.conf
RUN echo 'include "security-header.conf"' >> /etc/lighttpd/lighttpd.conf;

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
