FROM lupusmichaelis/igor:1.0.0 AS igor

FROM debian:jessie

# HTTP
RUN apt update \
    && apt dist-upgrade -y \
    && apt-get autoclean

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
CMD [ "bash" ]
