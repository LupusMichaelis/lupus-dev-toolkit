FROM lupusmichaelis/debian-buster

LABEL description="Debian Buster Linux with Node"

USER 0

# libtinfo5 : elm dependency
# cmdtest provides a command yarn that is not the yarn we know in the NodeJS realm
RUN apt update \
    && apt install \
        -y \
		bash \
		libtinfo5 \
		npm \
	&& apt-get clean

### Configure workspace ########################################################

ENV PATH "${ANVIL}/node_modules/.bin:$PATH"

COPY docker-entrypoint.sh /usr/local/bin/
COPY ./package.json-dist ${ANVIL}

### Configure user #############################################################
CMD ["npm", "start"]
