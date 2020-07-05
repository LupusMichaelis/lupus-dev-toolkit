#!/usr/bin/env bash

if [ ! -f package.json ]
then
    cp \
		"${LUPUSMICHAELIS_DIR}/node.package.json-dist" \
		package.json

	npm i --save \
		json-server@0.9.5

	chown -R $UID .
fi

exec "$@"
