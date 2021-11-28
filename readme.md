# Lupus' DevOps toolkit

This is a serie of tools for the developer lost in DevOps.

# Contributions

You're welcome to contribute. There is no proper guidelines or anything yet, feel free to
provide for it, and go through the
[project](/LupusMichaelis/lupus-dev-toolkit/projects/1)
to see what is to be done.

# Usage

## Make your own derived image

Let's say you want to use an Ubuntu based distribution:

```Dockerfile
# Base image to access igor helpers
FROM lupusmichaelis/igor:1.0.0 as igor
FROM ubuntu:hirsute

# Setup igor
COPY --from=igor / /usr/

ENV LUPUSMICHAELIS_DIR /usr/local/lib/lupusmichaelis
RUN mkdir -p ${LUPUSMICHAELIS_DIR}

ENV LUPUSMICHAELIS_DOCKER_ENTRIES_DIR ${LUPUSMICHAELIS_DIR}/docker-entries
RUN mkdir -p ${LUPUSMICHAELIS_DOCKER_ENTRIES_DIR}

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

# The usual working directory is defined through ANVIL (can be override at container setup)
ARG ANVIL
ENV ANVIL=$ANVIL

# This script will manage all docker entrypoint added from children images
ENTRYPOINT ["/usr/local/bin/lupusmichaelis-docker-entrypoint.sh"]

# Create and register a script that will be executed during container setup
RUN set -ex; \
	apt update; apt install -y bash; \
	{ \
		echo '#!/usr/bin/env bash'; \
		echo 'echo "Yolo, World!"'; \
	} > /tmp/ubuntu-entrypoint.sh; \
	chmod +x /tmp/ubuntu-entrypoint.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/ubuntu-entrypoint.sh

#
CMD ["bash"]
```

You'll build and run as this (or via docker compose):

```bash
docker build --build-arg ANVIL=/var/run/anvil -t hirsute .
docker run --rm -it hirsute bash
```

# Internals

## Ygor

`./bin/ygor` is a script providing shorthands for daily common tasks. Invoking it without
argument triggers the usage message. I usually make in an alias `y` to it.

## Helpers

A collection of shell scripts defining helper functions for usual daily development tasks.

* `csv.sh`: functions to manipulate spreadsheets from the command line
* `curl.sh`: [cUrl](https://curl.se/) session helpers (oauth token management)
* `json.sh`: manipulation of [JSON](https://www.json.org/json-en.html) payloads
* `mkdir-cd.sh`: make a directory and jump into it

## Docker images

Images are defined in various directories listed under `build`. The `./build-images`
script helps to build, sign and push images to
[Docker Hub](https://hub.docker.com/u/lupusmichaelis).

There is currently 2 different image flavours:

* hacking time images:
  images designed to embed tools for development and to be easy the use with bind mount
* shipping time images:
  images designed to be lean and secured, for safe shipping of your hand-crafted marvel

### Igor

A bare base image to embed in-container shell script helpers. Used to simplify Docker
Entrypoint and general operations done through `Dockerfile`.
