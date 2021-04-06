FROM lupusmichaelis/alpine:1.0.1
LABEL description="Alpine Linux with Lighttpd"

USER 0

RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            ca-certificates \
            lighttpd \
            openssl \
        && echo Apk done

RUN mkdir -p /var/run/lighttpd
RUN chown lighttpd:lighttpd /var/run/lighttpd

RUN sed -i \
    -e '/^# server\.port          = 81/s/^.*$/server.port = 80/' \
    -e '/^# server\.bind          = 81/s/^.*$/server.bind = 0.0.0.0/' \
    -e 's@/run/lighttpd.pid@/run/lighttpd/lighttpd.pid@' \
    /etc/lighttpd/lighttpd.conf

COPY docker-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh

COPY mod_fastcgi.conf debug.conf /etc/lighttpd/

WORKDIR "/var/www/localhost/htdocs"

# Lighttpd needs this file to exist to consider it as an actual candidate for directory
# index
RUN touch "index.php"

COPY library.sh ${LUPUSMICHAELIS_DIR}/lp-lighttpd.sh

ARG LIGHTTPD_PROXY=disable
ENV LIGHTTPD_PROXY=${LIGHTTPD_PROXY}
RUN if [ "${LIGHTTPD_PROXY}" = 'enable' ]; \
    then \
        sed -i \
            -e '/include "mod_fastcgi.conf"/s/#//' \
            -e 's#\#.*mod_alias.*,.*#    "mod_alias",#g' \
            /etc/lighttpd/lighttpd.conf; \
    fi

ARG LIGHTTPD_SECURE=disable
ENV LIGHTTPD_SECURE=${LIGHTTPD_SECURE}
RUN if [ "${LIGHTTPD_SECURE}" = 'enable' ]; \
    then \
        sed -i \
            -e '/^server\.port = 80/s/^.*$/server.port = 443/' \
            -e '/^# ssl\.engine    = "enable"/s/^.*$/ssl.engine = "enable"/' \
            -e '/^# ssl\.pemfile   = "server.pem"/s/^.*$/ssl.pemfile = "\/etc\/lighttpd\/server.pem"/' \
            -e '/server\.modules = (/a     "mod_openssl",' \
            /etc/lighttpd/lighttpd.conf; \
    fi

ARG LIGHTTPD_REWRITE=disable
ENV LIGHTTPD_REWRITE=${LIGHTTPD_REWRITE}
ARG LIGHTTPD_TARGET=/index.php
ENV LIGHTTPD_TARGET=${LIGHTTPD_TARGET}
RUN case "${LIGHTTPD_REWRITE}" in \
        always) \
            echo 'url.rewrite-once = ( "^.*$" => "'"$LIGHTTPD_TARGET"'" )' \
            ;; \
        when-not-found) \
            echo 'url.rewrite-if-not-file = ( "^/.*$" => "'"$LIGHTTPD_TARGET"'" )' \
            ;; \
        esac > /etc/lighttpd/mod_rewrite.conf; \
    sed -i \
        -e '/"mod_rewrite"/s/#//' \
        /etc/lighttpd/lighttpd.conf; \
    echo 'include "mod_rewrite.conf"' >> /etc/lighttpd/lighttpd.conf;

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
