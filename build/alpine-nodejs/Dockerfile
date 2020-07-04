FROM lupusmichaelis/alpine

LABEL description="Alpine Linux with user and NodeJS"

### Add Node JS packages #######################################################

USER root

RUN apk update \
    && apk add --no-cache \
        nodejs \
        npm

RUN npm config -g set package-lock false
RUN npm config -g set optional false
RUN npm config -g set ssl-strict=false
RUN npm config -g set registry http://registry.npmjs.org/

ENV PATH "$ANVIL/node_modules/.bin:$PATH"

COPY docker-entrypoint.sh /tmp/alpine-nodejs.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-nodejs.sh
CMD ["npm", "run"]
