#!/bin/sh

yarn init
yarn add elm@0.18
ln -s ../workshop/node_modules/elm/Elm-Platform/0.18.0/.cabal-sandbox/bin/* ~/bin/

elm init
