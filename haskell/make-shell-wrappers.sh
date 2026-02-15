#!/usr/bin/env bash
set -euo pipefail

BINARY_DIR="$PWD/.local/bin"
DOCKER_WRAPPER="$PWD/docker-wrapper.sh"

mkdir -p $BINARY_DIR

for BINARY_NAME in $(docker exec $CONTAINER find ~/.ghcup/bin \
			    -maxdepth 1 \( -type f -o -type l \) \
			    -executable -printf "%f\n"
		    )
do
    ln -sf $DOCKER_WRAPPER $BINARY_DIR/$BINARY_NAME
    chmod +x $BINARY_DIR/$BINARY_NAME
done
