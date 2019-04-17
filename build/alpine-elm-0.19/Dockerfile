FROM alpine:latest

LABEL description="Alpine Linux with Elm 0.19"

### Configure system ###########################################################

RUN apk update \
    && apk add --no-cache \
		bash \
		yarn

### Configure user #############################################################
RUN rmdir /home

ARG USER_ALIAS
ARG UID

RUN adduser -u ${UID} \
	-g "" \
	-D \
	-h /home \
	${USER_ALIAS}

RUN echo \
	'export PS1="\w $ "'\
	> /home/.profile

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

ENV YARNCMD=yarn
RUN ["igor", "setup"]

COPY  /home/anvil

#ENTRYPOINT ["igor", "setup"]

CMD ["igor", "run"]
