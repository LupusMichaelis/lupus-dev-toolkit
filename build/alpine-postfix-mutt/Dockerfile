FROM mickael/alpine-postfix

LABEL description="Alpine Linux with Postfix MTA and Mutt MUA"

### Configure system ###########################################################

USER 0
RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            mutt \
        && echo Apk done

ARG USER_ALIAS
USER ${USER_ALIAS}

CMD ["mutt"]
