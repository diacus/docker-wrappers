#!/usr/bin/env bash

set -euo pipefail

# Determine invoked command name
CMD="$(basename "$0")"

# Execute command inside container
if [ -t 1 ]; then
    exec docker exec -it "$CONTAINER" "$CMD" "$@"
else
    exec docker exec -i "$CONTAINER" "$CMD" "$@"
fi
