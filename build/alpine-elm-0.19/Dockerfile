FROM mickael/alpine-nodejs:latest

LABEL description="Alpine Linux with NodJS using Yarn"

### Install dependency of Elm exes #############################################
USER root

# gmp required by elm
# libc-compat required by elm-test
RUN apk update \
    && apk add --no-cache \
        gmp \
        libc6-compat

### Configure user #############################################################

ARG USER_ALIAS
ARG UID

USER ${USER_ALIAS}

ENV PATH "/home/anvil/node_modules/.bin:$PATH"

### Ensure consistency of workspace ############################################
COPY ./igor /home/bin/

ENV YARNCMD=yarn

CMD ["igor", "run"]
