# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_DEV_EMBER_VERSION
ARG LUPUSMICHAELIS_ALPINE_DEV_NODEJS_VERSION
FROM lupusmichaelis/alpine-nodejs:$LUPUSMICHAELIS_ALPINE_DEV_NODEJS_VERSION

LABEL description="Alpine Linux with user and NodeJS"

### Add Node JS packages #######################################################

CMD ["npm", "run"]
USER root

RUN npm i -g ember-cli@~2.15.0

COPY entrypoint /tmp/alpine-ember.sh
RUN lupusmichaelis-install-initializer /tmp/alpine-ember.sh
COPY ./package.json-dist "${LUPUSMICHAELIS_DIR}/node.package.json-dist"
