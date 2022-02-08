# syntax=docker/dockerfile-upstream:master-labs
ARG LUPUSMICHAELIS_ALPINE_DEV_VERSION

FROM lupusmichaelis/alpine-dev:$LUPUSMICHAELIS_ALPINE_DEV_VERSION

LABEL description="Alpine Linux with Elm 0.19.1"
CMD ["npm", "run", "start"]

USER root

RUN <<eos
# Install dependency of Elm exes
declare -ar package_list=(
	ca-certificates
	gmp # gmp required by elm
	libc6-compat # libc-compat required by elm-test
	npm
	openssl
)

lupusmichaelis-packaging-add ${package_list[@]}

npm c -g set package-lock false
npm c -g set optional false

eos

COPY entrypoint /tmp/alpine-elm-entrypoint
COPY package.json-dist elm.json-dist ${LUPUSMICHAELIS_DIR}/
COPY Main.elm ${LUPUSMICHAELIS_DIR}/Main.elm

RUN lupusmichaelis-install-initializer /tmp/alpine-elm-entrypoint

### Configure user #############################################################
ENV PATH "/home/anvil/node_modules/.bin:$PATH"
