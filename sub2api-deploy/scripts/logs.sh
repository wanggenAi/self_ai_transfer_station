#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${DEPLOY_DIR}"

if [ "${1:-}" = "" ]; then
  docker compose -f docker-compose.local.yml logs -f
else
  docker compose -f docker-compose.local.yml logs -f "$1"
fi
