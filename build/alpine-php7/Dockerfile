FROM lupusmichaelis/alpine

LABEL description="Alpine Linux with PHP7"

### Add PHP packages ##########################################################

USER root

RUN apk add --no-cache \
    php7 \
    php7-dom \
    php7-iconv \
    php7-json \
    php7-mbstring \
    php7-mysqli \
    php7-openssl \
    php7-tokenizer \
    php7-phar \
    php7-session \
    php7-xml \
    php7-xmlwriter

CMD ["php"]
