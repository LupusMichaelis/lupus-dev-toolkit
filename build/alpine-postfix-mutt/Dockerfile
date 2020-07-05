FROM lupusmichaelis/alpine-postfix

LABEL description="Alpine Linux with Postfix MTA and Mutt MUA"

### Configure system ###########################################################

USER 0
RUN apk add --no-cache \
        mutt \
        w3m \
    && echo Apk done

COPY docker-entrypoint.sh /tmp/alpine-postfix-mutt.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-postfix-mutt.sh

COPY muttrc /tmp/.muttrc
COPY mailcap /tmp/.mailcap

CMD ["mutt", "-f", "~/Maildir"]
