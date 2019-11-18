FROM mickael/alpine-lighttpd
LABEL description="Alpine Linux with Lighttpd over SSL"

USER 0

RUN apk add \
    --no-cache \
    openssl

RUN openssl \
    req \
    -subj '/CN=lupusmic.org/O=None/C=FR' \
    -newkey rsa:2048 \
    -nodes \
    -keyout /etc/lighttpd/server.key \
    -x509 \
    -days 365 \
    -out /etc/lighttpd/server.crt

RUN cat \
    /etc/lighttpd/server.key \
    /etc/lighttpd/server.crt \
    > /etc/lighttpd/server.pem

RUN chmod 400 \
    /etc/lighttpd/server.key \
    /etc/lighttpd/server.crt \
    /etc/lighttpd/server.pem

RUN sed -i \
    '/^server\.port = 80/s/^.*$/server.port = 443/' \
    /etc/lighttpd/lighttpd.conf \
        && \
    sed -i \
        '/^# ssl\.engine    = "enable"/s/^.*$/ssl.engine = "enable"/' \
        /etc/lighttpd/lighttpd.conf \
        && \
    sed -i \
        '/^# ssl\.pemfile   = "server.pem"/s/^.*$/ssl.pemfile = "\/etc\/lighttpd\/server.pem"/' \
        /etc/lighttpd/lighttpd.conf

ARG USER_ALIAS
USER ${USER_ALIAS}
CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
