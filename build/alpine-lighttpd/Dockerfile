# syntax=docker/dockerfile-upstream:master-labs
ARG LUPUSMICHAELIS_ALPINE_VERSION

FROM lupusmichaelis/alpine:$LUPUSMICHAELIS_ALPINE_VERSION
LABEL description="Alpine Linux with Lighttpd"

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]

USER 0

RUN <<eos
[ -v DEBUG ] &&
	set -x || set +x

declare -a packages=(
	ca-certificates
	lighttpd
	openssl
)

lupusmichaelis-packaging-add ${packages[@]}

mkdir -p /var/run/lighttpd
chown lighttpd:lighttpd /var/run/lighttpd /dev/fd/1 /dev/fd/2

sed -i \
	-e '/^# server\.port = 81/s/^.*$/server.port = 80/' \
	-e '/^# server\.bind = 81/s/^.*$/server.bind = 0.0.0.0/' \
	-e 's@/run/lighttpd.pid@/run/lighttpd/lighttpd.pid@' \
	-e 's@^server\.errorlog.*$@server.errorlog = "/dev/fd/2"@' \
	-e 's@^accesslog\.filename.*@accesslog.filename = "/dev/fd/1"@' \
	/etc/lighttpd/lighttpd.conf
eos

COPY entrypoint /tmp/alpine-lighttpd-proxy
RUN lupusmichaelis-install-entrypoint /tmp/alpine-lighttpd-proxy

COPY mod_fastcgi.conf debug.conf /etc/lighttpd/

WORKDIR "/var/www/localhost/htdocs"

COPY library ${LUPUSMICHAELIS_DIR}/lib/lighttpd

ARG LIGHTTPD_PROXY=disable
ENV LIGHTTPD_PROXY=${LIGHTTPD_PROXY}
RUN <<eot
if [ "${LIGHTTPD_PROXY}" = 'enable' ]
then
	sed -i \
		-e '/include "mod_fastcgi.conf"/s/#//' \
		-e 's#\#.*mod_alias.*,.*#	 "mod_alias",#g' \
		/etc/lighttpd/lighttpd.conf
	#Lighttpd needs this file to exist to consider it as an index candidate"
	touch index.php
fi
eot

ARG LIGHTTPD_SECURE=disable
ENV LIGHTTPD_SECURE=${LIGHTTPD_SECURE}
RUN <<eot
if [ "${LIGHTTPD_SECURE}" = 'enable' ]
then
	cat <<- eoc > /etc/lighttpd/lupusmichaelis.conf
		server.port = 443 \
		ssl.engine = "enable"
		ssl.pemfile = "/etc/lighttpd/server.pem"
		server.modules += ("mod_openssl")
	eoc

	printf "include \"lupusmichaelis.conf\"\n" >> /etc/lighttpd/lighttpd.conf
fi
eot

ARG LIGHTTPD_REWRITE=disable
ENV LIGHTTPD_REWRITE=${LIGHTTPD_REWRITE}
ARG LIGHTTPD_TARGET=/index.php
ENV LIGHTTPD_TARGET=${LIGHTTPD_TARGET}
RUN <<eos
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
			"^.*/$" => "\$0/index.php",
			"^.*$" => "$LIGHTTPD_TARGET"
		)
		eoc
		;;
esac > /etc/lighttpd/mod_rewrite.conf

printf "include \"mod_rewrite.conf\"\n" >> /etc/lighttpd/lighttpd.conf

sed -i \
	-e '/"mod_rewrite"/s/#//' \
	/etc/lighttpd/lighttpd.conf
eos

COPY security-header.conf /etc/lighttpd/security-header.conf
RUN printf "include \"security-header.conf\"\n" >> /etc/lighttpd/lighttpd.conf
