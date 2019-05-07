FROM alpine:latest

LABEL description="Alpine Linux with user"

### Configure system ###########################################################

USER 0
RUN apk update \
    apk upgrade --no-cache \
    apk add --no-cache bash \
    echo Apk done

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

CMD ["bash"]
