#!/usr/bin/env bash

set -e

target="practice-B"

echoI() { printf "\033[36m[INFO] $*\033[m\n"; }
echoS() { printf "\033[32m[SUCCESS] $*\033[m\n"; }
echoW() { printf "\033[3ym[WARNING] $*\033[m\n"; }
echoE() { printf "\033[31m[ERROR] $*\033[m\n"; exit 1; }

if [[ ! -d "${target}" ]]; then
    echoE "Not found '${target}' (Check your path is in '2021-hands-on/${target}')."
fi

if pgrep docker > /dev/null; then :; else
    echoE "docker is not running."
fi

_res="$(docker ps -a | grep practice-B)"
if [[ ${_res} =~ "practice-B" ]]; then
    echoW "A container named 'practice-B' already exists."
    echoW "Remove it and build a new conainter? [y/N]"
    read -n 1 _res
    if [[ _res == "y" ]]; then
        ./clean.bash
    else
        echoE "Stopped to build."
    fi
fi

cd "${target}"
pwd
if [[ ! -f "Dockerfile" ]]; then
    echoE "Not found 'Dockerfile'."
fi
docker build -f ./Dockerfile -t cefore/$target .
