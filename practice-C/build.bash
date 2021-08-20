#!/usr/bin/env bash

set -e

for target in base min cache csmgr; do
    (
        cd "$target"
        pwd
        docker build -f ./Dockerfile -t cefore/$target .
	# docker build --no-cache --progress=plain -f ./Dockerfile -t cefore/$target .
    ) || exit 1
done
