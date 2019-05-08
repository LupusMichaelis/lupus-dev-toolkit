FROM debian:buster

LABEL description="Debian Buster GNU/Linux with Elm 0.19"

### Configure system ###########################################################

RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
RUN apt update \
    && apt install -y \
		bash \
		libtinfo5 \
		npm \
	&& apt-get clean

RUN npm i -g \
    yarn

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

### Ensure consistency of workspace ############################################
COPY ./igor /home/bin/

ENV YARNCMD="npx yarn"

#ENTRYPOINT ["igor", "setup"]

CMD ["igor", "run"]
