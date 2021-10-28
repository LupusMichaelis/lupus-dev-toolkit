FROM lupusmichaelis/alpine:1.0.1

USER root
RUN apk update \
    && apk --no-cache add \
        mariadb \
        mariadb-client \
        mariadb-server-utils

ENV MYSQL_SYSUSER mysql
ENV MYSQL_SYSGROUP mysql
ENV MYSQL_DATA_PATH /var/lib/mysql
ENV MYSQL_ROOT_PASSWORD ''
ENV INIT_DIR /home/initialize

# This is a bit extreme, but so we can install as mysql user from the entrypoint
RUN chmod +s /usr/bin/mariadb-install-db

# Prepare directories
RUN mkdir -p /run/mysqld
RUN chown -R ${MYSQL_SYSUSER}:${MYSQL_SYSGROUP} /run/mysqld

RUN mkdir -p $MYSQL_DATA_PATH
RUN chown -R ${MYSQL_SYSUSER}:${MYSQL_SYSGROUP} ${MYSQL_DATA_PATH}
RUN chown -R ${MYSQL_SYSUSER}:${MYSQL_SYSGROUP} /var/log
VOLUME "${MYSQL_DATA_PATH}"/

# MariaDB will look of my.cnf
RUN mv /etc/my.cnf.d/mariadb-server.cnf /etc/my.cnf.d/00-mariadb-server.cnf
COPY mariadb.cnf /etc/my.cnf.d/10-lupusmichaelis.cnf

ENTRYPOINT ["docker-entrypoint.sh"]

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER ${MYSQL_SYSUSER}
CMD [ "mysqld_safe" ]

COPY ./initialize/ ${INIT_DIR}
