FROM alpine:latest

LABEL description="Alpine Linux with user"

### Configure system ###########################################################

USER 0
RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            bash \
        && echo Apk done

### Configure user #############################################################
ARG USER_ALIAS
ARG UID
ARG GID

RUN adduser \
    -u ${UID} \
	-g "" \
	-D \
	-h /home \
	${USER_ALIAS}

RUN echo \
	'export PS1="\w $ "'\
	> /home/.profile

RUN mkdir -p /home/bin
ENV PATH "/home/bin:$PATH"

### Configure workspace ########################################################
USER ${USER_ALIAS}

ENV ANVIL /home/anvil
RUN mkdir -p ${ANVIL}
WORKDIR ${ANVIL}

CMD ["bash"]
