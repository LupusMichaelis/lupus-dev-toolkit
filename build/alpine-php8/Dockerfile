# syntax=docker/dockerfile:1.5.1
ARG LUPUSMICHAELIS_ALPINE_DEV_VERSION

FROM lupusmichaelis/alpine-dev:$LUPUSMICHAELIS_ALPINE_DEV_VERSION

LABEL description="Alpine Linux with PHP8"

### Add PHP packages ##########################################################

CMD ["php81"]
USER root

ARG PHP_MODULES="dom iconv json mbstring openssl tokenizer phar session xml xmlwriter"
ENV PHP_MODULES=${PHP_MODULES}

RUN lupusmichaelis-packaging-add \
	php81 \
	$(for module in $PHP_MODULES; do echo "php81-$module"; done)

COPY entrypoint /tmp/alpine-php81
RUN lupusmichaelis-install-initializer /tmp/alpine-php81

ARG PHP_FPM
ENV PHP_FPM=${PHP_FPM:-disable}
RUN <<eos
if [ 'enable' = "$PHP_FPM" ]
then
	declare -ar packages=(
		php81-fpm
	)
	lupusmichaelis-packaging-add ${packages[@]}

	sed \
		-e '/^;chdir =/s/.*/chdir = \/home\/anvil\/public/' \
		-e 's/127.0.0.1:9000/9000/' \
		-e '/allowed_clients/d' \
		-e '/;catch_workers_output = /s/^;//' \
		-e '/;access\.log\s\+=/s/.*/access.log = \/proc\/1\/fd\/1/' \
		-i /etc/php81/php-fpm.d/www.conf

	sed \
		-e '#include_path =#s#"\(.*\)"#"\1:'"$ANVIL"'"#' \
		-e 's/;log_level = notice/log_level = debug/' \
		-e '/cgi\.fix_pathinfo/s/^;//' \
		-i /etc/php81/php.ini

	sed \
		-e 's/\(log_errors\)\s*=\s*.*\(;\?\)/\1=On\2/' \
		-e '/;error_log\s\+=/s/^.*$/error_log=\/proc\/1\/fd\/2/' \
		-i /etc/php81/php-fpm.conf
fi
eos

ARG PHP_COMPOSER
ENV PHP_COMPOSER=${PHP_COMPOSER:-disable}
RUN <<eot
if [ 'enable' = "$PHP_COMPOSER" ]
then
	declare -ar packages=(
		composer
		git
	)
	lupusmichaelis-packaging-add ${packages[@]}
fi
eot

ARG PHP_XDEBUG
ENV PHP_XDEBUG=${PHP_XDEBUG:-disable}
RUN <<eot
if [ 'enable' = "$PHP_XDEBUG" ]
then
	declare -ar packages=(
		php81-pecl-xdebug
	)
	lupusmichaelis-packaging-add ${packages[@]}
	sed -i \
		-e 's/\(max_input_vars\)\s*=\s*\d+/\1=10000/' \
		-e 's/\(memory_limit\)\s*=\s*.*\(;\?\)/\1=1G\2/' \
		-e 's/\(error_reporting\)\s=\s.*\(;\?\)/\1=E_ALL\2/' \
		-e 's/\(display_errors\)\s*=\s*.*\(;\?\)/\1=Off\2/' \
			/etc/php81/php.ini
fi
eot

RUN sed \
	-e 's/\(log_errors\)\s*=\s*.*\(;\?\)/\1=On\2/' \
	-e '/;error_log\s\+=/s/^.*$/error_log=\/proc\/1\/fd\/2/' \
	-i /etc/php81/php.ini
