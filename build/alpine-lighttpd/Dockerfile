FROM mickael/alpine
LABEL description="Alpine Linux with Lighttpd"

USER 0

RUN apk add --no-cache \
    lighttpd \
    ca-certificates

RUN sed -i \
    '/^# server\.port          = 81/s/^.*$/server.port = 8000/' \
    /etc/lighttpd/lighttpd.conf \
        && \
    sed -i \
        '/^# server\.bind          = 81/s/^.*$/server.bind = 0.0.0.0/' \
        /etc/lighttpd/lighttpd.conf

USER ${USER_ALIAS}

VOLUME ["/var/www/localhost/htdocs"]
WORKDIR "/var/www/localhost/htdocs"

EXPOSE 8000

ARG USER_ALIAS
USER ${USER_ALIAS}
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
