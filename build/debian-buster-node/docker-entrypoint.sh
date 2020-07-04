#!/bin/bash

if [ ! -f package.json ]
then
    mv package.json{-dist,}
	npm i --save \
		json-server@0.9.5

fi

exec "$@"
