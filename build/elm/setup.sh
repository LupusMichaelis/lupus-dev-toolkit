#!/bin/sh

yarn init
yarn add elm@0.18
ln -s ../workshop/node_modules/elm/binwrappers/* ~/bin/

elm init
