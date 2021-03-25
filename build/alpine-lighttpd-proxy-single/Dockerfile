FROM lupusmichaelis/alpine-lighttpd-proxy:1.0.1
LABEL description="Alpine Linux with Lighttpd proxying FPM on single point of entry"

RUN echo include "\"mod_rewrite.conf\"" >> /etc/lighttpd/lighttpd.conf

COPY mod_rewrite.conf /etc/lighttpd/

ENV USER_ALIAS "lighttpd"

CMD ["lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]
