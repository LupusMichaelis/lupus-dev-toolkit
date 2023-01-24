# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_VERSION

FROM lupusmichaelis/alpine:$LUPUSMICHAELIS_ALPINE_VERSION

CMD [ "/usr/sbin/httpd", "-X" ]

RUN <<eos
source $LUPUSMICHAELIS_DIR/lib/library
lupusmichaelis-debug-handle

declare -ar packages=(
	sed
	apache2
	apache2-http2
	apache2-proxy
	apache2-ssl
)

lupusmichaelis-packaging-add ${packages[@]}

tar c -j -f /etc-apache2.tar.bz -C /etc/apache2 .

declare -ar discarded_conf=(
	/etc/apache2/conf.d/default.conf
	/etc/apache2/conf.d/http2.conf
	/etc/apache2/conf.d/mpm.conf
	/etc/apache2/conf.d/userdir.conf
)

rm -f ${discarded_conf[@]}

sed \
	-e 's/^#\(LoadModule mpm_event_module modules\/mod_mpm_event\.so\)$/\1/' \
	-e 's/^#\(LoadModule mod_heartmonitor modules\/mod_heartmonitor\.so\)$/\1/' \
	-e 's/^LoadModule mpm_prefork_module modules\/mod_mpm_prefork\.so$/#&/' \
	-i /etc/apache2/httpd.conf
eos

COPY entrypoint /tmp/alpine-apache-entrypoint
RUN lupusmichaelis-install-initializer /tmp/alpine-apache-entrypoint

COPY httpd.conf /etc/apache2/
COPY conf.d/ /etc/apache2/conf.d/

ENV LUPUSMICHAELIS_APACHE_ADMIN_EMAIL=noc@example.com
ENV LUPUSMICHAELIS_APACHE_USER=apache
ENV LUPUSMICHAELIS_APACHE_GROUP=apache
ENv LUPUSMICHAELIS_APACHE_SERVER_NAME=lupusmichaelis.local
ENV LUPUSMICHAELIS_APACHE_LOCALHOST_ROOT=/var/www/localhost/htdocs
