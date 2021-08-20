#!/usr/bin/env bash

# time=`date +%Y%m%d-%H%M`
# mkdir -p ~/log_$time
# cp -r /tmp/log/* ~/log_$time
# rm -rf /tmp/log

export node_bindir=$(mktemp -d /tmp/tmp.XXXXXXXXX)
trap '[[ -d "${node_bindir:?}" && "${node_bindir::4}" = "/tmp" ]] && rm -rf "${node_bindir:?}"' EXIT
cp -r bin $node_bindir

docker-compose down
