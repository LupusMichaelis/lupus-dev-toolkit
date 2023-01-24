# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_VERSION
FROM lupusmichaelis/alpine:$LUPUSMICHAELIS_ALPINE_VERSION

ARG LUPUSMICHAELIS_ALPINE_VERSION
ENV LUPUSMICHAELIS_ALPINE_VERSION=${LUPUSMICHAELIS_ALPINE_VERSION}

ARG LUPUSMICHAELIS_ALPINE_MARIADB_VERSION
ENV LUPUSMICHAELIS_ALPINE_MARIADB_VERSION=${LUPUSMICHAELIS_ALPINE_MARIADB_VERSION}

ARG LUPUSMICHAELIS_ALPINE_MARIADB_SECURE
ENV LUPUSMICHAELIS_ALPINE_MARIADB_SECURE=${LUPUSMICHAELIS_ALPINE_MARIADB_SECURE:-enable}

ENV MYSQL_SYSUSER mysql
ENV MYSQL_SYSGROUP mysql
ENV MYSQL_DATA_PATH /var/lib/mysql
ENV MYSQL_ROOT_PASSWORD ''
ENV INIT_DIR /home/initialize
ENV MYSQL_SSL_PATH=/etc/ssl/mariadb

CMD [ "mysqld_safe" ]
ENTRYPOINT ["/usr/local/bin/lupusmichaelis-mariadb-entrypoint"]

HEALTHCHECK --interval=10s --timeout=20s --retries=10 \
    CMD mysqladmin ping

USER root
RUN <<eos

declare -a package_list=(
	mariadb
	mariadb-client
	mariadb-server-utils
)

if [ enable = "$LUPUSMICHAELIS_ALPINE_MARIADB_SECURE" ]
then
	package_list+=(
		openssl
	)
fi

lupusmichaelis-packaging-add ${package_list[@]}
eos

# This is a bit extreme, but so we can install as mysql user from the entrypoint
RUN chmod +s /usr/bin/mariadb-install-db

VOLUME "${MYSQL_DATA_PATH}"/

# Prepare directories
RUN <<eos
declare -ar mysql_path_list=(
	${MYSQL_DATA_PATH}
	/var/log
	/run/mysqld
)

mkdir -p ${mysql_path_list[@]}
chown -R ${MYSQL_SYSUSER}:${MYSQL_SYSGROUP} ${mysql_path_list[@]}
eos

# MariaDB will look of my.cnf
RUN mv /etc/my.cnf.d/mariadb-server.cnf /etc/my.cnf.d/00-mariadb-server.cnf

COPY mariadb.cnf /etc/my.cnf.d/10-lupusmichaelis.cnf
COPY entrypoint /usr/local/bin/lupusmichaelis-mariadb-entrypoint
COPY ./initialize/ ${INIT_DIR}
