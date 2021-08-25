#!/usr/bin/env bash

set -e

echoI() { printf "\033[34m[INFO] $*\033[m\n"; }
echoS() { printf "\033[32m[SUCCESS] $*\033[m\n"; }
echoW() { printf "\033[33m[WARNING] $*\033[m\n"; }
echoE() { printf "\033[31m[ERROR] $*\033[m\n"; exit 1; }

if [[ "$1" == "-a" ]]; then
    echoI "Answer mode."
    _answer_mode=true
else
    _answer_mode=false
fi

_reflect() {
    tgt="$1"
    name="b-$1"
    if $_answer_mode; then
        docker exec $name bash -c \
            "cp /cefore/bin/answers/cefore-conf.$tgt/* /usr/local/cefore/"
    else
        docker exec $name bash -c \
            "cp /cefore/bin/cefore-conf.$tgt/* /usr/local/cefore/"
    fi
}

_reflect consumer
_reflect router
_reflect producer
echoS "Completed."
