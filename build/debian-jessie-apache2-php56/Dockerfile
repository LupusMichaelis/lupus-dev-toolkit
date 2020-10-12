FROM lupusmichaelis/debian-jessie-php56:1.0.0

# HTTP
RUN apt update \
    && apt dist-upgrade -y \
    && apt install -y \
        libapache2-mod-php5 \
    && apt-get autoclean

RUN a2enmod \
    rewrite

CMD [ "apachectl", "-X" ]
