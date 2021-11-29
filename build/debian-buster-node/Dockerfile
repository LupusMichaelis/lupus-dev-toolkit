# syntax=docker/dockerfile-upstream:master-labs
FROM lupusmichaelis/debian-buster:1.0.1

LABEL description="Debian Buster Linux with Node"

USER 0

# libtinfo5 : elm dependency
# cmdtest provides a command yarn that is not the yarn we know in the NodeJS realm
RUN apt install \
        -y \
		bash \
		libtinfo5 \
		npm \
	&& apt-get clean

### Configure workspace ########################################################

ENV PATH "${ANVIL}/node_modules/.bin:$PATH"

COPY docker-entrypoint.sh /tmp/debian-buster-node.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/debian-buster-node.sh
COPY ./package.json-dist "${LUPUSMICHAELIS_DIR}/node.package.json-dist"

RUN npm c -g set package-lock false \
    && npm c -g set optional false \
    && npm c -g set ssl-strict=false \
    && npm c -g set registry http://registry.npmjs.org/

### Configure user #############################################################
CMD ["npm", "start"]
