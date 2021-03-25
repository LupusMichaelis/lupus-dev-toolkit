FROM lupusmichaelis/alpine-lighttpd:1.0.1
LABEL description="Alpine Linux with Lighttpd proxying FPM"

COPY docker-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh

RUN sed -i \
    -e '/include "mod_fastcgi.conf"/s/#//' \
    -e 's#\#.*mod_alias.*,.*#    "mod_alias",#g' \
    /etc/lighttpd/lighttpd.conf

COPY mod_fastcgi.conf /etc/lighttpd/

# Lighttpd needs this file to exist to consider it as an actual candidate for directory
# index
RUN touch "index.php"

ENV USER_ALIAS "lighttpd"

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
