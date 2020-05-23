FROM lupusmichaelis/alpine
LABEL description="Alpine Linux with Lighttpd"

USER 0

RUN apk add --no-cache \
    lighttpd \
    ca-certificates

RUN sed -i \
    '/^# server\.port          = 81/s/^.*$/server.port = 80/' \
    /etc/lighttpd/lighttpd.conf \
        && \
    sed -i \
        '/^# server\.bind          = 81/s/^.*$/server.bind = 0.0.0.0/' \
        /etc/lighttpd/lighttpd.conf

ARG USER_ALIAS
USER ${USER_ALIAS}

WORKDIR "/var/www/localhost/htdocs"

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
