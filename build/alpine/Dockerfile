FROM alpine:3.12.0 AS gosu-builder
RUN apk update \
        && apk upgrade --no-cache \
        && apk add --no-cache \
            gcc \
            git \
            go \
            musl-dev \
        && echo Apk done
RUN go get github.com/tianon/gosu

FROM alpine:3.12.0

LABEL description="Alpine Linux with user"
ENV PATH "${PATH}":/home/go/bin/
COPY --from=gosu-builder /root/go/bin/gosu /home/go/bin/

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
