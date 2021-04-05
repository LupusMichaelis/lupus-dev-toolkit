### Reference igor script container ############################################
FROM lupusmichaelis/igor:1.0.0 AS igor

### Comman base to actual image and gosu builder environment ###################
FROM debian:buster AS debian-buster

RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
COPY ./etc/apt/apt.conf.d/ /etc/apt/apt.conf.d/
RUN apt update \
    && apt dist-upgrade \
        -y \
    && apt install \
        -y \
        ca-certificates \
    && apt-get clean \
    && echo Apt done

### Build gosu #################################################################
FROM debian-buster AS gosu-builder

RUN apt update \
    && apt dist-upgrade \
        -y \
    && apt install \
        -y \
        gcc \
        git \
        golang \
        libc-dev \
    && echo Apt done

RUN go get github.com/tianon/gosu

### Actual image ###############################################################
FROM debian-buster

USER 0

LABEL description="Alpine Linux with user"
ENV PATH "${PATH}":/go/bin/
COPY --from=gosu-builder /root/go/bin/gosu /go/bin/

### Configure system ###########################################################
RUN sed -i 's/main/main non-free contrib/g' /etc/apt/sources.list
COPY ./etc/apt/apt.conf.d/ /etc/apt/apt.conf.d/
RUN apt update \
    && apt install \
        -y \
        bash \
	&& apt-get clean \
        && echo Apt done

### Configure workspace ########################################################
RUN rmdir /home
ENV ANVIL /home/anvil

ENV LUPUSMICHAELIS_DIR /usr/local/lib/lupusmichaelis
RUN mkdir -p "${LUPUSMICHAELIS_DIR}"

ENV LUPUSMICHAELIS_DOCKER_ENTRIES_DIR ${LUPUSMICHAELIS_DIR}/docker-entries
RUN mkdir -p "${LUPUSMICHAELIS_DOCKER_ENTRIES_DIR}"

COPY --from=igor library.sh \
    install-entrypoint.sh \
    docker-entrypoint.sh \
    "${LUPUSMICHAELIS_DIR}/"

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/install-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-install-entrypoint.sh

RUN ln -s \
    ${LUPUSMICHAELIS_DIR}/docker-entrypoint.sh \
    /usr/local/bin/lupusmichaelis-docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/lupusmichaelis-docker-entrypoint.sh"]
CMD ["bash"]
