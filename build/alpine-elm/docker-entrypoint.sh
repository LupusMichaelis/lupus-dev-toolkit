#!/bin/bash

# npm init -q
if [ ! -f package.json ]
then
    mv package.json{-dist,}
fi

# Install language base
npm i --save \
    elm@0.19

# Install fake API provider
npm i --save \
    json-server@0.9.5

for package in \
    elm-lang/html \
    elm-lang/http \
    elm-lang/json \
    elm-lang/random \
    elm-lang/time
    do elm package install -y $package
done

mkdir -p src
touch src/index.js

exec "$@"
