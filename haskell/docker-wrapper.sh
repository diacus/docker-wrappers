#!/usr/bin/env bash
set -euo pipefail

# Determine invoked command name
CMD="$(basename "$0")"

if [ -z "${SERVICE:-}" ]; then
  echo "SERVICE variable is not set."
  exit 1
fi

if ! docker compose config --services | grep -qx "$SERVICE"; then
  echo "Service '$SERVICE' not found in docker-compose.yml."
  exit 1
fi

# Check if service is running
if ! docker compose ps --services --filter "status=running" | grep -qx "$SERVICE"; then
  echo "▶ Starting service $SERVICE..."
  docker compose up -d "$SERVICE"
fi

if [ -t 1 ]; then
  exec docker compose exec "$SERVICE" "$CMD" "$@"
else
  exec docker compose exec -T "$SERVICE" "$CMD" "$@"
fi
