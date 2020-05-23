FROM lupusmichaelis/alpine-postfix

LABEL description="Alpine Linux with Postfix MTA and Mutt MUA"

### Configure system ###########################################################

USER 0
RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            mutt \
            w3m \
        && echo Apk done

ARG USER_ALIAS
USER ${USER_ALIAS}

COPY muttrc /home/.muttrc
COPY mailcap /home/.mailcap
RUN mkdir /home/Maildir

CMD ["mutt", "-f", "~/Maildir"]
