#!/bin/bash

openssl \
    req \
    -subj '/CN=lupusmic.org/O=None/C=FR' \
    -newkey rsa:2048 \
    -nodes \
    -keyout /etc/lighttpd/server.key \
    -x509 \
    -days 365 \
    -out /etc/lighttpd/server.crt

cat \
    /etc/lighttpd/server.key \
    /etc/lighttpd/server.crt \
    > /etc/lighttpd/server.pem

chmod 400 \
    /etc/lighttpd/server.key \
    /etc/lighttpd/server.crt \
    /etc/lighttpd/server.pem
