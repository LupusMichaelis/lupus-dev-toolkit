# syntax=docker/dockerfile-upstream:master-labs
ARG LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION
ARG LUPUSMICHAELIS_IGOR_VERSION

## Subsystem  igor #############################################################
FROM lupusmichaelis/igor:$LUPUSMICHAELIS_IGOR_VERSION AS igor

## Subsystem Alpine with Igor ##################################################
FROM debian:$LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION AS base-with-igor

SHELL [ "/bin/bash", "-euo", "pipefail", "-c" ]


### Configure system ###########################################################
USER 0

ENV LUPUSMICHAELIS_DIR /usr/local/lib/lupusmichaelis
ENV PATH=$PATH:$LUPUSMICHAELIS_DIR/bin
RUN mkdir -p ${LUPUSMICHAELIS_DIR}/bin ${LUPUSMICHAELIS_DIR}/lib

ENV LUPUSMICHAELIS_DOCKER_ENTRIES_DIR=${LUPUSMICHAELIS_DIR}/docker-entries
RUN mkdir -p ${LUPUSMICHAELIS_DOCKER_ENTRIES_DIR}

ARG LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION
ENV LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION=${LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION}

ARG LUPUSMICHAELIS_IGOR_VERSION
ENV LUPUSMICHAELIS_IGOR_VERSION=${LUPUSMICHAELIS_IGOR_VERSION}

COPY --from=igor \
	library \
	${LUPUSMICHAELIS_DIR}/lib/

COPY --from=igor \
	library \
	install-initializer \
	docker-entrypoint \
	${LUPUSMICHAELIS_DIR}/bin/

COPY \
	packaging-add \
	packaging-init \
	${LUPUSMICHAELIS_DIR}/bin/

RUN <<eos
source $LUPUSMICHAELIS_DIR/lib/library
lupusmichaelis-debug-handle

declare -ar utilities=(
	install-initializer
	docker-entrypoint
	packaging-add
	packaging-init
)

for utility in ${utilities[@]}
do
	ln -s \
		"${LUPUSMICHAELIS_DIR}/bin/$utility" \
		"/usr/local/bin/lupusmichaelis-$utility"
done

eos

RUN lupusmichaelis-packaging-init

## Subsystem to build suexec ###################################################
FROM base-with-igor AS suexec-builder
SHELL [ "/bin/bash", "-euo", "pipefail", "-c" ]
RUN <<eos
source $LUPUSMICHAELIS_DIR/lib/library
lupusmichaelis-debug-handle

declare -ar packages=(
	git
	build-essential
)

lupusmichaelis-packaging-add ${packages[@]}

cd /tmp
git clone https://github.com/ncopa/su-exec
cd su-exec
make
strip su-exec

eos

## Actual System ###############################################################
FROM base-with-igor
LABEL description="Debian GNU/Linux Bullseye with su-exec and igor helpers"
SHELL [ "/bin/bash", "-euo", "pipefail", "-c" ]
ENTRYPOINT ["/usr/local/bin/lupusmichaelis-docker-entrypoint"]
CMD ["bash"]

COPY --from=suexec-builder /tmp/su-exec/su-exec $LUPUSMICHAELIS_DIR/bin/

### Configure workspace ########################################################
ENV ANVIL /home/anvil
WORKDIR ${ANVIL}
