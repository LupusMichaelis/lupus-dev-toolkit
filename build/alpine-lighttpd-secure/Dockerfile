FROM lupusmichaelis/alpine-lighttpd
LABEL description="Alpine Linux with Lighttpd over SSL"

USER 0

RUN apk add \
    --no-cache \
    openssl

RUN sed -i \
    -e '/^server\.port = 80/s/^.*$/server.port = 443/' \
    -e '/^# ssl\.engine    = "enable"/s/^.*$/ssl.engine = "enable"/' \
    -e '/^# ssl\.pemfile   = "server.pem"/s/^.*$/ssl.pemfile = "\/etc\/lighttpd\/server.pem"/' \
    -e '/server\.modules = (/a     "mod_openssl",' \
    /etc/lighttpd/lighttpd.conf

COPY docker-entrypoint.sh /tmp/alpine-lighttpd-secure.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-lighttpd-secure.sh

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
