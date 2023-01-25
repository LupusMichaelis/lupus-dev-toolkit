# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_DEV_VERSION
FROM lupusmichaelis/alpine-dev:$LUPUSMICHAELIS_ALPINE_DEV_VERSION

LABEL description="Alpine Linux with user and NodeJS"

### Add Node JS packages #######################################################

CMD ["npm", "run"]
USER root
ENV PATH "$ANVIL/node_modules/.bin:$PATH"

RUN <<eos
lupusmichaelis-packaging-add nodejs npm

npm c -g set package-lock false
npm c -g set optional false
npm c -g set ssl-strict=false
npm c -g set registry http://registry.npmjs.org/

eos

COPY entrypoint /tmp/alpine-nodejs.sh
RUN lupusmichaelis-install-initializer /tmp/alpine-nodejs.sh
COPY ./package.json-dist "${LUPUSMICHAELIS_DIR}/node.package.json-dist"
