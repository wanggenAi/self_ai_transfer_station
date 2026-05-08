#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEPLOY_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
cd "${DEPLOY_DIR}"

if [ ! -f .env.example ]; then
  echo "[ERROR] .env.example not found in ${DEPLOY_DIR}" >&2
  exit 1
fi

if [ -f .env ]; then
  backup=".env.bak.$(date +%Y%m%d%H%M%S)"
  cp .env "${backup}"
  echo "[INFO] Existing .env backed up to ${backup}"
fi

cp .env.example .env

POSTGRES_PASSWORD="$(openssl rand -hex 24)"
REDIS_PASSWORD="$(openssl rand -hex 24)"
JWT_SECRET="$(openssl rand -hex 48)"
TOTP_ENCRYPTION_KEY="$(openssl rand -hex 32)"

TMP_FILE="$(mktemp)"
awk -F= -v pg="${POSTGRES_PASSWORD}" -v rp="${REDIS_PASSWORD}" -v jwt="${JWT_SECRET}" -v totp="${TOTP_ENCRYPTION_KEY}" '
BEGIN { OFS="=" }
$1=="BIND_HOST" { $0="BIND_HOST=127.0.0.1" }
$1=="POSTGRES_PASSWORD" { $0="POSTGRES_PASSWORD=" pg }
$1=="REDIS_PASSWORD" { $0="REDIS_PASSWORD=" rp }
$1=="JWT_SECRET" { $0="JWT_SECRET=" jwt }
$1=="TOTP_ENCRYPTION_KEY" { $0="TOTP_ENCRYPTION_KEY=" totp }
{ print }
' .env > "${TMP_FILE}"

mv "${TMP_FILE}" .env
chmod 600 .env

mkdir -p data postgres_data redis_data

echo "[OK] .env generated with secure random secrets"
echo "[OK] Local-only bind enforced: BIND_HOST=127.0.0.1"
echo "[OK] Data directories ensured: data/ postgres_data/ redis_data/"
