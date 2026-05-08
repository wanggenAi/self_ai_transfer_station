#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${DEPLOY_DIR}"

if [ ! -f .env ]; then
  echo "[ERROR] .env not found. Run: ./scripts/init-env.sh" >&2
  exit 1
fi

docker compose -f docker-compose.local.yml up -d
docker compose -f docker-compose.local.yml ps
