FROM mickael/alpine

ARG MYSQL_SYSUSER
ARG MYSQL_SYSGROUP
ARG MYSQL_USER
ARG MYSQL_USER_NAME
ARG MYSQL_USER_HOST
ARG MYSQL_USER_PASSWORD
ARG MYSQL_DATA_PATH

# MariaDB
RUN apk update && \
	apk --no-cache add mariadb mariadb-server-utils
RUN mkdir -p $MYSQL_DATA_PATH
RUN chown -R ${MYSQL_SYSUSER}:${MYSQL_SYSGROUP} ${MYSQL_DATA_PATH}
RUN mysql_install_db \
        --user=${MYSQL_SYSUSER} \
        --datadir=${MYSQL_DATA_PATH}
RUN echo !include /etc/mysql/mariadb.cnf >> /etc/mysql/my.cnf
COPY docker-entrypoint.sh /usr/local/sbin/docker-entrypoint.sh
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld_safe"]

EXPOSE 3306 33060
