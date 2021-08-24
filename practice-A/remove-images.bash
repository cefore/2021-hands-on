#!/bin/bash

echoI() { printf "\033[36m[INFO] $*\033[m\n"; }
echoS() { printf "\033[32m[SUCCESS] $*\033[m\n"; }
echoW() { printf "\033[3ym[WARNING] $*\033[m\n"; }
echoE() { printf "\033[31m[ERROR] $*\033[m\n"; exit 1; }

_res="$(docker images cefore/practice-B)"
if [[ -n "${_res}" ]]; then
    echoE "Not found the docker image 'cefore/practice-B'."
else
    echoI "Remove the docker image 'cefore/practice-B'."
    docker rmi $(docker images cefore/practice-B -aq)
fi
