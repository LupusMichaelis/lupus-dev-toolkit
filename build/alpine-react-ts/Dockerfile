# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_DEV_REACT_TS_VERSION
ARG LUPUSMICHAELIS_ALPINE_DEV_REACT_VERSION
FROM lupusmichaelis/alpine-react:$LUPUSMICHAELIS_ALPINE_DEV_REACT_VERSION

LABEL description="Alpine Linux with dev user and React on NodeJS using TypeScript"

USER root

RUN npm install -g \
    eslint \
    eslint-config-prettier \
    eslint-plugin-react \
    ts-loader \
    typescript \
    @typescript-eslint/eslint-plugin \
    @typescript-eslint/parser \
    @types/react \
    @types/react-dom \
    @types/react-router-dom

COPY setup "${LUPUSMICHAELIS_DIR}/setup-react-ts"
