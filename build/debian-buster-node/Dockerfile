FROM lupusmichaelis/debian-buster

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
COPY ./package.json-dist ${ANVIL}

RUN npm config -g set package-lock false
RUN npm config -g set optional false
RUN npm config -g set ssl-strict=false
RUN npm config -g set registry http://registry.npmjs.org/

### Configure user #############################################################
CMD ["npm", "start"]
