# syntax=docker/dockerfile-upstream:master-labs

ARG LUPUSMICHAELIS_IGOR_VERSION
ARG LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION

### Reference igor script container ############################################
FROM lupusmichaelis/igor:$LUPUSMICHAELIS_IGOR_VERSION AS igor

### Comman base to actual image and gosu builder environment ###################
FROM debian:$LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION AS debian-buster

RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
COPY ./etc/apt/apt.conf.d/ /etc/apt/apt.conf.d/
RUN apt update -yqq \
    && apt dist-upgrade \
        -yqq \
    && apt install \
        -yqq \
        ca-certificates \
    && apt-get clean \
    && echo Apt done

### Build gosu #################################################################
FROM debian-buster AS gosu-builder

RUN apt install \
        -yqq \
        gcc \
        git \
        golang \
        libc-dev \
    && echo Apt done

RUN go get github.com/tianon/gosu

### Actual image ###############################################################
FROM debian-buster

ARG LUPUSMICHAELIS_IGOR_VERSION
ENV LUPUSMICHAELIS_IGOR_VERSION=${LUPUSMICHAELIS_IGOR_VERSION}

ARG LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION
ENV LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION=${LUPUSMICHAELIS_OFFICIAL_DEBIAN_VERSION}


ENTRYPOINT ["/usr/local/bin/lupusmichaelis-docker-entrypoint.sh"]
CMD ["bash"]

USER 0

LABEL description="Alpine Linux with user"
ENV PATH "${PATH}":/go/bin/
COPY --from=gosu-builder /root/go/bin/gosu /go/bin/

### Configure system ###########################################################
RUN apt install \
        -yqq \
        bash \
	&& apt-get clean \
        && echo Apt done

### Configure workspace ########################################################
RUN rmdir /home
ENV ANVIL /home/anvil

ENV LUPUSMICHAELIS_DOCKER_ENTRIES_DIR ${LUPUSMICHAELIS_DIR}/docker-entries
RUN mkdir -p "${LUPUSMICHAELIS_DOCKER_ENTRIES_DIR}"

ENV LUPUSMICHAELIS_DIR /usr/local/lib/lupusmichaelis
RUN mkdir -p "${LUPUSMICHAELIS_DIR}"

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/install-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-install-entrypoint.sh

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/docker-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-docker-entrypoint.sh

COPY --from=igor library.sh \
    install-entrypoint.sh \
    docker-entrypoint.sh \
    "${LUPUSMICHAELIS_DIR}/"
