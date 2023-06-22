# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION
FROM alpine:$LUPUSMICHAELIS_OFFICIAL_ALPINE_VERSION AS base-with-igor

WORKDIR /dev-tools
RUN apk add --no-cache bash
SHELL [ "/bin/bash", "-euo", "pipefail", "-c" ]
ENTRYPOINT [ "/checkout-and-build" ]
CMD [ "*", "latest"]

ENV COMPOSE_DOCKER_CLI_BUILD=1
ENV DOCKER_BUILDKIT=1

RUN <<eos
set -euo pipefail

declare -ar packages=(
	docker-cli
	docker-cli-compose
	git
)

apk add --no-cache ${packages[@]}
eos

COPY checkout-and-build /
