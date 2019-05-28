FROM mickael/alpine

LABEL description="Alpine Linux with Postfix MTA and Mutt MUA"

### Configure system ###########################################################

USER root
RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
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

ENTRYPOINT ["docker-entrypoint.sh"]
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

ARG USER_ALIAS

COPY ./aliases /etc/aliases
RUN echo '/.+@.+/ '${USER_ALIAS} \
    > /etc/postfix/virtual-regexp
RUN touch /etc/postfix/virtual
COPY ./postfix-aliases /etc/postfix/aliases

RUN postmap \
    /etc/postfix/aliases \
    /etc/postfix/virtual \
    /etc/postfix/virtual-regexp

COPY ./aliases /etc/aliases

COPY ./rsyslog.conf /etc/rsyslog.conf

CMD ["rsyslogd", "-n"]
