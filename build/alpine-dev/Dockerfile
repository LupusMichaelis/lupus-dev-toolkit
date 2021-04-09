### Subsystem  igor ############################################################
FROM lupusmichaelis/alpine:1.0.1 AS igor
LABEL description="Alpine Linux with dev user"

ARG LP_DEV_USER_ALIAS
ARG LP_DEV_UID
ARG LP_DEV_GID

ENV USER_ALIAS ${LP_DEV_USER_ALIAS}
ENV UID ${LP_DEV_UID}
ENV GID ${LP_DEV_GID}
