FROM lupusmichaelis/alpine:1.0.1
LABEL description="Alpine Linux with Lighttpd"

USER 0

RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            bash \
            lighttpd \
            ca-certificates \
        && echo Apk done

RUN mkdir -p /var/run/lighttpd
RUN chown lighttpd:lighttpd /var/run/lighttpd

RUN sed -i \
    -e '/^# server\.port          = 81/s/^.*$/server.port = 80/' \
    -e '/^# server\.bind          = 81/s/^.*$/server.bind = 0.0.0.0/' \
    -e 's@/run/lighttpd.pid@/run/lighttpd/lighttpd.pid@' \
    /etc/lighttpd/lighttpd.conf

COPY library.sh ${LUPUSMICHAELIS_DIR}/lp-lighttpd.sh

WORKDIR "/var/www/localhost/htdocs"

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
