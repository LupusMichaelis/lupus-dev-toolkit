#!/usr/bin/env bash

if [ ! -f package.json ]
then
	gosu "${USER_ALIAS}" \
		cp \
			"${LUPUSMICHAELIS_DIR}/node.package.json-dist" \
			package.json

	gosu "${USER_ALIAS}" \
		npm i --save \
			json-server@0.9.5
else
	gosu "${USER_ALIAS}" \
		npm i
fi

exec "$@"
