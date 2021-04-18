#!/usr/bin/env bash

cp \
	/tmp/.muttrc \
	/tmp/.mailcap \
	/home

mkdir -p /home/Mail{,dir/{cur,new,tmp}}

chown -R "${LP_DEV_USER_ALIAS}" /home
