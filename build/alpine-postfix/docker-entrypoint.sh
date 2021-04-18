#!/bin/sh

echo '/.+@.+/ '${LP_DEV_USER_ALIAS} \
	> /etc/postfix/virtual-regexp
touch /etc/postfix/virtual
postmap \
    /etc/postfix/aliases \
    /etc/postfix/virtual \
    /etc/postfix/virtual-regexp

postfix start
