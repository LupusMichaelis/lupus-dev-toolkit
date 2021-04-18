FROM lupusmichaelis/alpine-nodejs:1.0.4

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
ENV PATH "/home/anvil/node_modules/.bin:$PATH"
