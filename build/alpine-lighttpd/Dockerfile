FROM lupusmichaelis/alpine:1.0.0
LABEL description="Alpine Linux with Lighttpd"

USER 0

RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            bash \
            lighttpd \
            ca-certificates \
        && echo Apk done

RUN sed -i \
    -e '/^# server\.port          = 81/s/^.*$/server.port = 80/' \
    -e '/^# server\.bind          = 81/s/^.*$/server.bind = 0.0.0.0/' \
    /etc/lighttpd/lighttpd.conf

WORKDIR "/var/www/localhost/htdocs"

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
