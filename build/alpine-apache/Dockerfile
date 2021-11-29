# syntax=docker/dockerfile-upstream:master-labs
ARG LUPUSMICHAELIS_ALPINE_VERSION

FROM lupusmichaelis/alpine:$LUPUSMICHAELIS_ALPINE_VERSION

CMD [ "/usr/sbin/httpd", "-X" ]

RUN <<eos
#!/usr/bin/env bash

set -euo pipefail
[ -v DEBUG ] &&
	set -x || set +x

declare -ar packages=(
	apache2
	apache2-http2
	apache2-proxy
	apache2-ssl
)

apk add --no-cache ${packages[@]}

rm /etc/apache2/conf.d/userdir.conf

sed \
	-e 's/^#\(LoadModule mpm_event_module modules\/mod_mpm_event\.so\)$/\1/' \
	-e 's/^#\(LoadModule mod_heartmonitor modules\/mod_heartmonitor\.so\)$/\1/' \
	-e 's/^LoadModule mpm_prefork_module modules\/mod_mpm_prefork\.so$/#&/' \
	-i /etc/apache2/httpd.conf
eos

COPY conf.d/ /etc/apache2/conf.d/
