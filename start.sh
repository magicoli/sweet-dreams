#!/bin/sh
# Wires our own files into the untouched magicmirror npm package, then starts
# MagicMirror in server-only mode (no Electron/display needed in the container).
set -e

PGM=$(basename "$0")
BASE_DIR=$(cd "$(dirname "$0")" && pwd)
MM_BASE_DIR="${MM_BASE_DIR:-${BASE_DIR}/node_modules/magicmirror}"

log() {
	echo "$PGM: $@" >&2
}

log Starting $PGM

if [ -f ~/.nvm/nvm.sh ]; then
	. ~/.nvm/nvm.sh
fi

if [ -f "$BASE_DIR/.env" ]; then
	. "$BASE_DIR/.env"
fi

APP_ENV="${APP_ENV:-local}"
export MM_CONFIG_FILE
export MM_MODULES_DIR
export MM_CUSTOMCSS_FILE
export MM_PORT

[ -d node_modules/magicmirror ] || exit 1

npm start

# npm run build -- --outDir "${MM_BASE_DIR}/config"
# rsync -Wavz "${BASE_DIR}/modules/" "${MM_BASE_DIR}/modules/"
#
# cd node_modules/magicmirror
#
# exec npm run server
