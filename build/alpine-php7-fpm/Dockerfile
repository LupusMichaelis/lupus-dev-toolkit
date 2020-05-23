FROM lupusmichaelis/alpine-php7

LABEL description="Alpine Linux with PHP7 FPM"

ARG UID
ARG USER_ALIAS

### Add PHP packages ###########################################################

USER root

RUN apk add --no-cache \
    php7-fpm

RUN sed \
    -e '/^;chdir = /s/.*/chdir = \/home\/anvil\/public/' \
    -e 's/127.0.0.1:9000/9000/' \
    -e '/allowed_clients/d' \
    -e '/error_log/d' \
    -e '/;catch_workers_output = /s/^;//' \
    -i /etc/php7/php-fpm.d/www.conf
RUN sed \
    -e '/include_path =/s/"\(.*\)"/"\1:\/home\/anvil"/' \
    -e 's/;log_level = notice/log_level = debug/' \
    -i /etc/php7/php.ini
RUN chown $UID /var/log/php7/

### Configure workspace ########################################################

USER ${USER_ALIAS}
RUN mkdir -p /home/anvil/public

ENTRYPOINT /usr/sbin/php-fpm7 --nodaemonize
