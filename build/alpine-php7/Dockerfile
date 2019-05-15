FROM mickael/alpine

LABEL description="Alpine Linux with PHP7"

### Add Node JS packages #######################################################

USER root

RUN apk add --no-cache \
    php7

ARG USER_ALIAS
ARG UID

### Configure workspace ########################################################
USER ${USER_ALIAS}

CMD ["php"]
