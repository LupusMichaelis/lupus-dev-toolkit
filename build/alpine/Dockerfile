# syntax=docker/dockerfile-upstream:master-labs
ARG LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION
ARG LUPUSMICHAELIS_IGOR_VERSION

### Subsystem  igor ############################################################
FROM lupusmichaelis/igor:$LUPUSMICHAELIS_IGOR_VERSION AS igor

### Subsystem to build gosu ####################################################
FROM alpine:$LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION AS gosu-builder
RUN <<eos
#!/usr/bin/env sh

set -euo pipefail
[ -v DEBUG ] &&
	set -x || set +x

apk update
apk upgrade --no-cache

apk add --no-cache \
	gcc \
	git \
	go \
	musl-dev

echo Apk done
eos

RUN go get github.com/tianon/gosu

### Actual System ##############################################################
FROM alpine:$LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION
LABEL description="Alpine Linux with gosu and igor helpers"
ENTRYPOINT ["/usr/local/bin/lupusmichaelis-docker-entrypoint.sh"]
CMD ["bash"]

ENV PATH "${PATH}":/home/go/bin/
COPY --from=gosu-builder /root/go/bin/gosu /home/go/bin/

### Configure system ###########################################################
USER 0
RUN <<eos
#!/usr/bin/env sh

set -euo pipefail
[ -v DEBUG ] &&
	set -x || set +x

apk update
apk upgrade --no-cache
apk add --no-cache bash
echo Apk done
eos
### Configure workspace ########################################################
ENV ANVIL /home/anvil
WORKDIR ${ANVIL}

ENV LUPUSMICHAELIS_DIR /usr/local/lib/lupusmichaelis
RUN mkdir -p ${LUPUSMICHAELIS_DIR}

ENV LUPUSMICHAELIS_DOCKER_ENTRIES_DIR=${LUPUSMICHAELIS_DIR}/docker-entries
RUN mkdir -p ${LUPUSMICHAELIS_DOCKER_ENTRIES_DIR}

ARG LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION
ENV LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION=${LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION}

ARG LUPUSMICHAELIS_IGOR_VERSION
ENV LUPUSMICHAELIS_IGOR_VERSION=${LUPUSMICHAELIS_IGOR_VERSION}

COPY --from=igor \
    library.sh \
    install-entrypoint.sh \
    docker-entrypoint.sh \
    ${LUPUSMICHAELIS_DIR}/

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/install-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-install-entrypoint.sh

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/docker-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-docker-entrypoint.sh
