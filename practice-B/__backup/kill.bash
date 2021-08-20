#!/usr/bin/env bash

export node_bindir=$(mktemp -d /tmp/tmp.XXXXXXXXX)
trap '[[ -d "${node_bindir:?}" && "${node_bindir::4}" = "/tmp" ]] && rm -rf "${node_bindir:?}"' EXIT
cp -r bin $node_bindir

docker-compose kill

