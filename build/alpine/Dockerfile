### Subsystem  igor ############################################################
FROM lupusmichaelis/igor:1.0.0 AS igor

### Subsystem to build gosu ####################################################
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

### Actual System ##############################################################
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

ENV LUPUSMICHAELIS_DIR /usr/local/lib/lupusmichaelis
RUN mkdir -p ${LUPUSMICHAELIS_DIR}

ENV LUPUSMICHAELIS_DOCKER_ENTRIES_DIR ${LUPUSMICHAELIS_DIR}/docker-entries
RUN mkdir -p ${LUPUSMICHAELIS_DOCKER_ENTRIES_DIR}

COPY --from=igor library.sh \
    install-entrypoint.sh \
    docker-entrypoint.sh \
    ${LUPUSMICHAELIS_DIR}/

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/install-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-install-entrypoint.sh

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/docker-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/lupusmichaelis-docker-entrypoint.sh"]
CMD ["bash"]
