FROM lupusmichaelis/alpine-dev:1.0.2

LABEL description="Alpine Linux with PHP7"

### Add PHP packages ##########################################################

USER root

ARG PHP_MODULES="dom iconv json mbstring openssl tokenizer phar session xml xmlwriter"
ENV PHP_MODULES=${PHP_MODULES}

RUN apk add --no-cache \
        php7 \
        $(for module in $PHP_MODULES; do echo "php7-$module"; done)

COPY docker-entrypoint.sh /tmp/alpine-php7.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/alpine-php7.sh

ARG PHP_FPM
ENV PHP_FPM=${PHP_FPM:-disable}
RUN if [ 'enable' = "$PHP_FPM" ]; \
    then \
        apk add --no-cache \
            php7-fpm; \
        sed \
            -e '/^;chdir =/s/.*/chdir = \/home\/anvil\/public/' \
            -e 's/127.0.0.1:9000/9000/' \
            -e '/allowed_clients/d' \
            -e '/error_log/d' \
            -e '/;catch_workers_output = /s/^;//' \
            -e '/;access\.log = /c access.log = \/var\/log\/php7\/www.access.log'\
            -i /etc/php7/php-fpm.d/www.conf; \
        sed \
            -e '#include_path =#s#"\(.*\)"#"\1:'"$ANVIL"'"#' \
            -e 's/;log_level = notice/log_level = debug/' \
            -e '/cgi\.fix_pathinfo/s/^;//' \
            -i /etc/php7/php.ini; \
    fi

ARG PHP_COMPOSER
ENV PHP_COMPOSER=${PHP_COMPOSER:-disable}
RUN if [ 'enable' = "$PHP_COMPOSER" ]; \
    then \
        apk add --no-cache \
            composer \
            git; \
    fi

ARG PHP_XDEBUG
ENV PHP_XDEBUG=${PHP_XDEBUG:-disable}
RUN if [ 'enable' = "$PHP_XDEBUG" ]; \
    then \
        apk add --no-cache \
            php7-pecl-xdebug; \
        sed -i \
            -e 's/\(max_input_vars\)\s*=\s*\d+/\1=10000/' \
            -e 's/\(memory_limit\)\s*=\s*.*\(;\?\)/\1=1G\2/' \
            -e 's/\(error_reporting\)\s=\s.*\(;\?\)/\1=E_ALL\2/' \
            -e 's/\(log_errors\)\s*=\s*.*\(;\?\)/\1=On\2/' \
            -e 's/\(display_errors\)\s*=\s*.*\(;\?\)/\1=Off\2/' \
                /etc/php7/php.ini; \
    fi

CMD ["php"]
