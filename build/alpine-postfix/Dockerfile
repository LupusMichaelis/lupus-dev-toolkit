# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_DEV_VERSION
FROM lupusmichaelis/alpine-dev:$LUPUSMICHAELIS_ALPINE_DEV_VERSION

LABEL description="Alpine Linux with Postfix MTA and Mutt MUA"

CMD ["postfix", "start-fg"]
WORKDIR /root
VOLUME /root/Maildir
VOLUME /root/Mail

USER root
RUN <<eos

declare -ar packages=(
	postfix
	postfix-pcre
)

lupusmichaelis-packaging-add ${packages[@]}
mkdir -p /root/Mail{,dir/{cur,new,tmp}}
eos

## Postfix configuration
RUN <<eos
sed -i \
    -e 's/#\(inet_interfaces = all\)/\1/' \
    -e 's/#\(mynetworks_style = subnet\)/\1/' \
    -e 's/#\(relay_domains = $mydestination\)/\1/' \
    -e 's/#\(home_mailbox = Maildir\/\)/\1/' \
    -e 's/#\(inet_interfaces = all\)/\1/' \
    -e 's/#\(local_recipient_maps =\)$/\1/' \
    /etc/postfix/main.cf

postconf maillog_file=/dev/stdout
eos

COPY ./aliases /etc/aliases
COPY ./postfix-aliases /etc/postfix/aliases

RUN <<eos
echo "virtual_maps = hash:/etc/postfix/virtual, regexp:/etc/postfix/virtual-regexp" \
	>> /etc/postfix/main.cf
echo '/.+@.+/ root' \
	> /etc/postfix/virtual-regexp
postmap /etc/postfix/virtual-regexp
postmap /etc/postfix/virtual
postmap /etc/postfix/aliases

sed -i \
    -e 's/#\(inet_interfaces = all\)/\1/' \
    -e 's/#\(mynetworks_style = subnet\)/\1/' \
    -e 's/#\(relay_domains = $mydestination\)/\1/' \
    -e 's/#\(home_mailbox = Maildir\/\)/\1/' \
    -e 's/#\(inet_interfaces = all\)/\1/' \
    -e 's/#\(local_recipient_maps =\)$/\1/' \
    /etc/postfix/main.cf
eos

COPY entrypoint /tmp/alpine-postfix
RUN lupusmichaelis-install-entrypoint /tmp/alpine-postfix
