FROM lupusmichaelis/alpine-php7

LABEL description="Alpine Linux with PHP7 and debug"

USER root

RUN apk add --no-cache \
    composer \
    git \
    php7-pecl-xdebug

RUN sed -i \
	-e 's/\(max_input_vars\)\s*=\s*\d+/\1=10000/' \
	-e 's/\(memory_limit\)\s*=\s*.*\(;\?\)/\1=1G\2/' \
		/etc/php7/php.ini;

# Debug settings
RUN sed -i \
	-e 's/\(error_reporting\)\s=\s.*\(;\?\)/\1=E_ALL\2/' \
	-e 's/\(log_errors\)\s*=\s*.*\(;\?\)/\1=On\2/' \
	-e 's/\(display_errors\)\s*=\s*.*\(;\?\)/\1=Off\2/' \
		/etc/php7/php.ini;

CMD ["composer"]
