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
#!/bin/bash

set -euo pipefail

declare -ar packages=(
	docker-cli
	docker-cli-compose
	git
)

apk add --no-cache ${packages[@]}

cat <<- 'eof' > /checkout-and-build
#!/bin/bash

set -euo pipefail

declare -r namespace=lupusmichaelis
declare -r image_name="$1"
declare -r image_version="$2"

declare -r full_image_name="$namespace/$image_name:$image_version"
declare -r image_tag="$namespace/$image_name@$image_version"

git clone /dev-tools.git /dev-tools
git checkout "$image_tag"
cp /dev-tools.env /dev-tools/.env

docker compose -f builder.docker-compose.yml build --progress plain "$image_name"

eof
chmod +x /checkout-and-build

eos

COPY .env /dev-tools.env
