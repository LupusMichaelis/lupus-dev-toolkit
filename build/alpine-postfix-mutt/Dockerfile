# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_DEV_VERSION
FROM lupusmichaelis/alpine-dev:$LUPUSMICHAELIS_ALPINE_DEV_VERSION

LABEL description="Alpine Linux with Postfix MTA and Mutt MUA"
CMD ["mutt", "-f", "~/Maildir"]

### Configure system ###########################################################

USER 0
RUN lupusmichaelis-packaging-add mutt w3m

COPY entrypoint /tmp/alpine-postfix-mutt
RUN lupusmichaelis-install-initializer /tmp/alpine-postfix-mutt

COPY muttrc /tmp/.muttrc
COPY mailcap /tmp/.mailcap
