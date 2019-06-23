FROM mickael/alpine
LABEL description="Alpine Linux with HTTP Proxy"

USER 0

RUN apk add --no-cache \
    squid

ARG USER_ALIAS
USER ${USER_ALIAS}
CMD ["squid"]
