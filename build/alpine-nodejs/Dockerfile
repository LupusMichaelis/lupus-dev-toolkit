FROM lupusmichaelis/alpine

LABEL description="Alpine Linux with user and NodeJS"

### Add Node JS packages #######################################################

USER root

RUN apk update \
    && apk add --no-cache \
        nodejs \
        npm

RUN npm c -g set package-lock false \
    && npm c -g set optional false \
    && npm c -g set ssl-strict=false \
    && npm c -g set registry http://registry.npmjs.org/

ENV PATH "$ANVIL/node_modules/.bin:$PATH"

COPY docker-entrypoint.sh /tmp/alpine-nodejs.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-nodejs.sh
COPY ./package.json-dist "${LUPUSMICHAELIS_DIR}/node.package.json-dist"

CMD ["npm", "run"]
