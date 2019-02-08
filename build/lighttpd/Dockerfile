FROM alpine
LABEL description="Alpine Linux providing Bulma through Lighttpd"

RUN apk add --no-cache lighttpd ca-certificates

RUN sed -i \
    '/^# server\.port          = 81/s/^.*$/server.port = 8000/' \
    /etc/lighttpd/lighttpd.conf \
        && \
    sed -i \
        '/^# server\.bind          = 81/s/^.*$/server.bind = 0.0.0.0/' \
        /etc/lighttpd/lighttpd.conf

VOLUME ["/var/www/localhost/htdocs"]
WORKDIR "/var/www/localhost/htdocs"

EXPOSE 8000

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
