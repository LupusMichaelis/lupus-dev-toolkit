FROM debian:buster

LABEL description="Debian Buster GNU/Linux with Node"

### Configure system ###########################################################
USER 0
RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
COPY ./etc/apt/apt.conf.d/ /etc/apt/apt.conf.d/

# libtinfo5 : elm dependency
# cmdtest provides a command yarn that is not the yarn we know in the NodeJS realm
RUN apt update \
    && apt install -y \
		bash \
		libtinfo5 \
		npm \
	&& apt-get clean

### Configure user #############################################################
ARG USER_ALIAS
ARG UID

RUN rmdir /home
RUN adduser --uid ${UID} \
	--gecos '""' \
	--disabled-password \
	--home /home \
	${USER_ALIAS}

### Configure workspace ########################################################
RUN echo \
	'export PS1="\w $ "'\
	> /home/.bashrc

RUN mkdir /home/bin
ENV PATH "/home/bin:$PATH"

USER ${USER_ALIAS}

RUN mkdir /home/anvil
WORKDIR /home/anvil

ENV PATH "/home/anvil/node_modules/.bin:$PATH"

RUN apt update \
    && apt install -y \
		bash \
		libtinfo5 \
		npm \
	&& apt-get clean

COPY docker-entrypoint.sh /usr/local/bin/
COPY ./package.json-dist /home/anvil

### Configure user #############################################################
USER ${USER_ALIAS}
CMD ["npm", "start"]
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
