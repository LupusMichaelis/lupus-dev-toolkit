FROM lupusmichaelis/alpine-lighttpd
LABEL description="Alpine Linux with Lighttpd proxying FPM"

COPY docker-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-lighttpd-proxy.sh

RUN sed -i \
    -e '/include "mod_fastcgi.conf"/s/#//' \
    -e 's#\#.*mod_alias.*,.*#    "mod_alias",#g' \
    /etc/lighttpd/lighttpd.conf

COPY mod_fastcgi.conf /etc/lighttpd/

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
