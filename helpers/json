#!/bin/bash

json-date()
{
    date --utc -d "$1" '+%Y-%m-%dT%H:%M:%SZ'
}

json-inspect()
{
    jq . | gview -c ':set filetype=json' -
}
