#!/bin/sh
# Starts MagicMirror² from lib/ in server-only mode, with the .env settings.
set -e

PGM=$(basename "$0")
BASE_DIR=$(cd "$(dirname "$0")" && pwd)
MM_BASE_DIR="${MM_BASE_DIR:-${BASE_DIR}/lib/MagicMirror}"

DEBUG=${DEBUG:-yes}

log() {
	[ -n "${1:-}" -a -n "$DEBUG" -a "$DEBUG" = "yes" ] &&
		echo "$PGM: $@" >&2 ||
		true
}

if [ -f ~/.nvm/nvm.sh ]; then
	. ~/.nvm/nvm.sh
fi

if [ -f "$BASE_DIR/.env" ]; then
	. "$BASE_DIR/.env"
fi

APP_NAME=${APP_NAME:-"Sweet Dreams"}
APP_ENV="${APP_ENV:-local}"
if [ -n "${APP_ENV:-}" -a "${APP_ENV}" != "production" ]; then
	APP_NAME="$APP_NAME (${APP_ENV})"
fi

log "Start ${APP_NAME} MagicMirror²"
log "Base dir: $MM_BASE_DIR"
log "MagicMirror² dir: $MM_BASE_DIR"
log "Node version: $(node -v)"
export MM_CONFIG_FILE=${MM_CONFIG_FILE-${MM_BASE_DIR}/config/config.js}
export MM_CUSTOMCSS_FILE=${MM_CUSTOMCSS_FILE-${MM_BASE_DIR}/config/custom.css}
export MM_MODULES_DIR=${MM_MODULES_DIR-${MM_BASE_DIR}/modules}
export MM_PORT=${MM_PORT:-8080}

cd $MM_BASE_DIR
log "config: $(realpath $MM_CONFIG_FILE)"
log "css: $(realpath $MM_CUSTOMCSS_FILE)"
log "modules: $(realpath $MM_MODULES_DIR)/"
log "port: $MM_PORT"

npm run server
