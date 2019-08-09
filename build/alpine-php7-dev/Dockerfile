FROM mickael/alpine

LABEL description="Alpine Linux with PHP7 and debug"

### Add Node JS packages #######################################################

USER root

RUN apk add --no-cache \
    composer \
    git \
    php7 \
    php7-dom \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-openssl \
    php7-tokenizer \
    php7-phar \
    php7-xml \
    php7-xmlwriter \
    php7-pecl-xdebug

RUN sed -i \
	-e 's/\(max_input_vars\)\s*=\s*\d+/\1=10000/' \
	-e 's/\(memory_limit\)\s*=\s*.*\(;\?\)/\1=1G\2/' \
		/etc/php7/php.ini;

# Debug settings
## TODO: web-dev Dockerfile

RUN sed -i \
	-e 's/\(error_reporting\)\s=\s.*\(;\?\)/\1=E_ALL\2/' \
	-e 's/\(log_errors\)\s*=\s*.*\(;\?\)/\1=On\2/' \
	-e 's/\(display_errors\)\s*=\s*.*\(;\?\)/\1=Off\2/' \
		/etc/php7/php.ini;

ARG USER_ALIAS
ARG UID

### Configure workspace ########################################################
USER ${USER_ALIAS}

CMD ["php", "vendor/bin/phpunit", "tests"]
