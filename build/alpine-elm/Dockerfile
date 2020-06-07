FROM lupusmichaelis/alpine-nodejs:latest

LABEL description="Alpine Linux with Elm 0.19"

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