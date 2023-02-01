# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_DEV_REACT_VERSION
ARG LUPUSMICHAELIS_ALPINE_DEV_NODEJS_VERSION
FROM lupusmichaelis/alpine-nodejs:$LUPUSMICHAELIS_ALPINE_DEV_NODEJS_VERSION

LABEL description="Alpine Linux with dev user and React on NodeJS"

CMD ["npm", "run", "start"]
USER root

COPY setup "${LUPUSMICHAELIS_DIR}/setup-react"

RUN npm install -g \
    create-react-app
