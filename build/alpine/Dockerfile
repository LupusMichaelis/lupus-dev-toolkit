# syntax=docker/dockerfile-upstream:master-labs
ARG LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION
ARG LUPUSMICHAELIS_IGOR_VERSION

## Subsystem  igor #############################################################
FROM lupusmichaelis/igor:$LUPUSMICHAELIS_IGOR_VERSION AS igor

## Subsystem Alpine with Igor ##################################################
FROM alpine:$LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION AS base-with-igor

SHELL [ "/bin/sh", "-euo", "pipefail", "-c" ]

### Configure system ###########################################################
USER 0

ENV LUPUSMICHAELIS_DIR /usr/local/lib/lupusmichaelis
RUN mkdir -p ${LUPUSMICHAELIS_DIR}/bin ${LUPUSMICHAELIS_DIR}/lib

ENV LUPUSMICHAELIS_DOCKER_ENTRIES_DIR=${LUPUSMICHAELIS_DIR}/docker-entries
RUN mkdir -p ${LUPUSMICHAELIS_DOCKER_ENTRIES_DIR}

ARG LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION
ENV LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION=${LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION}

ARG LUPUSMICHAELIS_IGOR_VERSION
ENV LUPUSMICHAELIS_IGOR_VERSION=${LUPUSMICHAELIS_IGOR_VERSION}

COPY --from=igor \
	library \
	${LUPUSMICHAELIS_DIR}/lib/

COPY --from=igor \
	library \
	install-entrypoint \
	docker-entrypoint \
	${LUPUSMICHAELIS_DIR}/bin/

COPY \
	packaging-add \
	packaging-init \
	${LUPUSMICHAELIS_DIR}/bin/

RUN "${LUPUSMICHAELIS_DIR}/bin/packaging-add" bash

RUN <<eos
[ -v DEBUG ] && set -x || set +x

declare -ar utilities=(
	install-entrypoint
	docker-entrypoint
	packaging-add
	packaging-init
)

for utility in ${utilities[@]}
do
	ln -s \
		${LUPUSMICHAELIS_DIR}/bin/$utility \
		/usr/local/bin/lupusmichaelis-$utility
done

eos

RUN lupusmichaelis-packaging-init

## Subsystem to build gosu #####################################################
FROM base-with-igor AS gosu-builder
SHELL [ "/bin/bash", "-euo", "pipefail", "-c" ]
RUN <<eos
[ -v DEBUG ] &&
	set -x || set +x

declare -a packages=(
	gcc
	git
	go
	musl-dev
)

lupusmichaelis-packaging-add ${packages[@]}
eos

RUN go get github.com/tianon/gosu

## Actual System ###############################################################
FROM base-with-igor
LABEL description="Alpine Linux with gosu and igor helpers"
SHELL [ "/bin/bash", "-euo", "pipefail", "-c" ]
ENTRYPOINT ["/usr/local/bin/lupusmichaelis-docker-entrypoint"]
CMD ["bash"]

ENV PATH "${PATH}":/home/go/bin/
COPY --from=gosu-builder /root/go/bin/gosu /home/go/bin/

### Configure workspace ########################################################
ENV ANVIL /home/anvil
WORKDIR ${ANVIL}
