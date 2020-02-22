#!/bin/bash

curl-die()
{
    printf "Dying on: '$1'\n"
    return 1
}

curl-token-get()
{
    local namespace=$1
    local name=$(curl-token-name $namespace)
    echo ${!name}
}

curl-token-set()
{
    local namespace=$1
    local name=$(curl-token-name $namespace)
    local value=$2

    eval $name=\$value
}

curl-token-name()
{
    local namespace=$1

    if [[ -z "$namespace" ]]
    then
        curl-die "You ought to provide a namespace for your token"
    fi

    echo $namespace'_token'
}

curl-auth-clear()
{
    local namespace=$1
    unset $namespace
}

curl-is-authenticated()
{
    local auth_tokenname="token$1"
    [[ ! -z "${auth_tokenname}" ]]
}

curl-do-authenticated-call()
{
    local namespace=$1
    shift

    tokenname=$(curl-token-name $namespace)

    curl-is-authenticated $tokenname
    if [[ $? -eq 1 ]]
    then
        curl-die 'You aren'\''t authenticated'
    else
        curl \
            -k \
            -u ${!tokenname} \
            "$@"
    fi
}
