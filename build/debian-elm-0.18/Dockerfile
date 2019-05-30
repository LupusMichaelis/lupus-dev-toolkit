FROM mickael/debian-buster-node

LABEL description="Debian Buster GNU/Linux with Elm"

### Configure system ###########################################################

RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
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
	--gecos "" \
	--disabled-password \
	--home /home \
	${USER_ALIAS}

RUN echo \
	'export PS1="\w $ "'\
	> /home/.bashrc

RUN mkdir /home/bin
ENV PATH "/home/bin:$PATH"

### Configure workspace ########################################################
USER ${USER_ALIAS}

RUN mkdir /home/anvil
VOLUME ["/home/anvil"]
WORKDIR /home/anvil

ENV PATH "/home/anvil/node_modules/.bin:$PATH"

CMD ["npm", "run", "elm-reactor", "-a", "0.0.0.0"]
