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

### Configure workspace ########################################################
ENV ANVIL /home/anvil
WORKDIR ${ANVIL}

CMD ["bash"]
