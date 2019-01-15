#!/bin/sh

npm init
npm install elm@0.18
ln -s ../anvil/node_modules/elm/binwrappers/* ~/bin/

elm-package install -y elm-lang/html
