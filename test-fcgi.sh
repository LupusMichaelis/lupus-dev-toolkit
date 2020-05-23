#!/bin/bash

if [ "" == "$1" ]
then

    echo "$0 [script_name]"
    exit
fi

IP=172.24.0.2
PORT=9000

SCRIPT_NAME=$1 \
SCRIPT_FILENAME=$1 \
REQUEST_METHOD=GET \
cgi-fcgi -bind -connect $IP:$PORT
