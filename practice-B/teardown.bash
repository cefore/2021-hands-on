#!/usr/bin/env bash

set -e

echoI() { printf "\033[34m[INFO] $*\033[m\n"; }
echoS() { printf "\033[32m[SUCCESS] $*\033[m\n"; }
echoW() { printf "\033[33m[WARNING] $*\033[m\n"; }
echoE() { printf "\033[31m[ERROR] $*\033[m\n"; exit 1; }

_read_yml() {
    cat ./docker-settings/docker-compose.yml
}

if pgrep docker > /dev/null; then :; else
    echoE "docker is not running."
fi

_read_yml | docker-compose -f - down

if [[ "$1" == "-f" ]]; then
    echoI "Initialize configuration files."
    rm -rf ./bin/cefore-conf.consumer
    rm -rf ./bin/cefore-conf.router
    rm -rf ./bin/cefore-conf.producer
    cp -r ./bin/cefore-conf.default ./bin/cefore-conf.consumer
    cp -r ./bin/cefore-conf.default ./bin/cefore-conf.router
    cp -r ./bin/cefore-conf.default ./bin/cefore-conf.producer
fi
