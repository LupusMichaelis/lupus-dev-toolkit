FROM debian:jessie

# SMTP
COPY dpkg-postfix /root/

RUN apt update \
    && apt dist-upgrade -y \
    && debconf-set-selections /root/dpkg-postfix \
    && apt install -y \
        postfix \
    && apt-get autoclean

RUN cp /usr/share/postfix/main.cf.debian /etc/postfix/main.cf \
    && echo "* m.wolff@elpev.com" \
        > /etc/postfix/aliases \
    && postmap /etc/postfix/virtual-regexp \
    && echo "virtual_maps = hash:/etc/postfix/virtual, hash:/etc/postfix/aliases" \
        > /etc/postfix/main.cf \
    && touch /etc/postfix/virtual && postmap /etc/postfix/virtual

COPY ./launch-services /root

ENTRYPOINT [ "bash", "/root/launch-services" ]

CMD [ "bash" ]
