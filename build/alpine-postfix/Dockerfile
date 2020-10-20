FROM lupusmichaelis/alpine:1.0.0

LABEL description="Alpine Linux with Postfix MTA and Mutt MUA"

### Configure system ###########################################################

USER root
RUN apk add --no-cache \
        postfix \
        postfix-pcre \
        rsyslog \
    && echo Apk done

RUN sed -i \
    -e 's/#\(inet_interfaces = all\)/\1/' \
    -e 's/#\(mynetworks_style = subnet\)/\1/' \
    -e 's/#\(relay_domains = $mydestination\)/\1/' \
    -e 's/#\(home_mailbox = Maildir\/\)/\1/' \
    -e 's/#\(inet_interfaces = all\)/\1/' \
    -e 's/#\(local_recipient_maps =\)$/\1/' \
    /etc/postfix/main.cf

RUN echo "virtual_maps = hash:/etc/postfix/virtual, regexp:/etc/postfix/virtual-regexp" \
    >> /etc/postfix/main.cf

COPY docker-entrypoint.sh /tmp/alpine-postfix.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-postfix.sh

COPY ./aliases /etc/aliases
COPY ./postfix-aliases /etc/postfix/aliases

COPY ./rsyslog.conf /etc/rsyslog.conf

CMD ["rsyslogd", "-n"]
