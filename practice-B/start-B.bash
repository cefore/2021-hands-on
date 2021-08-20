#!/usr/bin/env bash

mkdir -p /tmp/log

export node_bindir=$(mktemp -d /tmp/tmp.XXXXXXXXX)
# trap '[[ -d "${node_bindir:?}" && "${node_bindir::4}" = "/tmp" ]] && rm -rf "${node_bindir:?}"' EXIT
cp -r bin $node_bindir

docker-compose build
docker-compose up -d
docker ps -a | sed -E 's/ ( +)/\1|/g' | cut -f 1,2,4,5 -d "|" | sed -E 's/ +$//g'

docker exec publisher /cefore/bin/publisher.bash
docker exec consumer /cefore/bin/consumer.bash
