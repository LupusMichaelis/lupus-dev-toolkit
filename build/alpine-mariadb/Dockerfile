FROM mickael/alpine

USER root
RUN apk update \
    && apk --no-cache add \
        mariadb \
        mariadb-client \
        mariadb-server-utils

ENV MYSQL_SYSUSER=mysql
ENV MYSQL_SYSGROUP=mysql
ENV MYSQL_DATA_PATH "/var/lib/mysql"

# Prepare directories
RUN mkdir -p /run/mysqld
RUN chown -R ${MYSQL_SYSUSER}:${MYSQL_SYSGROUP} /run/mysqld

RUN mkdir -p $MYSQL_DATA_PATH
RUN chown -R ${MYSQL_SYSUSER}:${MYSQL_SYSGROUP} ${MYSQL_DATA_PATH}

# MariaDB will look of my.cnf
RUN mv /etc/my.cnf.d/mariadb-server.cnf /etc/my.cnf.d/00-mariadb-server.cnf
COPY mariadb.cnf /etc/my.cnf.d/10-mickael.cnf

# Initialization of DB files
RUN mysql_install_db \
    --skip-test-db \
    --user=${MYSQL_SYSUSER} \
    --datadir=${MYSQL_DATA_PATH}

ENTRYPOINT ["docker-entrypoint.sh"]

ARG MYSQL_USER_NAME
ARG MYSQL_USER_PASSWORD
ARG MYSQL_USER_DATABASE

ENV MYSQL_USER_NAME=${MYSQL_USER_NAME}
ENV MYSQL_USER_PASSWORD=${MYSQL_USER_PASSWORD}
ENV MYSQL_USER_DATABASE=${MYSQL_USER_DATABASE}

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

USER ${MYSQL_SYSUSER}
CMD [ "mysqld_safe" ]
