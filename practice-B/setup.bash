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

# Remove containers if already exists.
_res="$(docker ps -aq --filter 'name=b-*')"
if [[ -n "${_res}" ]]; then
    echoW "Docker containers already exists."
    docker ps -a --filter 'name=b-*'
    echoW "Recreate the containers? (y/N)"
    read -n 1 _res
    echo
    if [[ $_res == "y" ]]; then
        ./teardown.bash
    else
        echoE "Stop setup process."
    fi
fi

echoI "Build docker images."
_read_yml | docker-compose -f - build

echoI "Compose docker containers."
_read_yml | docker-compose -f - up -d

echoI "Check docker containers are up."
docker ps --filter 'name=b-*'
_is_container_down() {
    _res="$(docker ps -q --filter "name=$1")"
    if [[ -n "${_res}" ]]; then
        return 1
    else
        return 0
    fi
}

for target in producer router consumer; do
    name="b-${target}"
    if _is_container_down $name; then
        echoE "$name is down."
    fi
done
echoS "Completed."