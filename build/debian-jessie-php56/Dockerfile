FROM lupusmichaelis/igor:1.0.0 AS igor

FROM lupusmichaelis/debian-jessie:1.0.0

RUN apt update \
    && apt dist-upgrade -y \
    && apt install -y \
        php5-cli \
        php5-curl \
        php5-gd \
        php5-imagick \
        php5-mcrypt \
        php5-mysql \
        php5-xdebug \
        xmlstarlet \
        wget \
    && apt-get autoclean \
    && echo Apt done

RUN php5enmod \
    mysqli \
    pdo_mysql \
    xdebug

RUN sed -i \
    -e 's/\s*\(max_execution_time\)\s*=\s*.\+/\1 = 90/' \
    -e 's/;\s*\(max_input_vars\)\s*=\s*.\+/\1 = 10000/' \
    -e 's/\s*\(memory_limit\)\s*=\s*.\+/\1 = 4096M/' \
        /etc/php5/cli/php.ini

RUN xmlstarlet ed -L \
    -s /policymap -t elem -n policy \
    -i '$prev' -t attr -n domain -v coder \
    -i '$prev/..' -t attr -n rights -v "read|write" \
    -i '$prev/..' -t attr -n pattern -v PDF \
    /etc/ImageMagick-6/policy.xml

CMD [ "php" ]

RUN mkdir -p /var/app/
WORKDIR /var/app/
VOLUME /var/app

RUN mkdir -p /var/www/
VOLUME /var/www

COPY docker-entrypoint.sh /tmp/debian-jessie-php56.sh
RUN lupusmichaelis-install-entrypoint.sh /tmp/debian-jessie-php56.sh

COPY composer-install.sh /usr/local/bin/
#RUN /usr/local/bin/composer-install.sh
