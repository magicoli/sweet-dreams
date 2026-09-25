#!/bin/sh
# Wires our own files into the untouched magicmirror npm package, then starts
# MagicMirror in server-only mode (no Electron/display needed in the container).
set -e

BASE_DIR=$(cd "$(dirname "$0")" && pwd)

if [ -f "$BASE_DIR/.env" ]; then
	source "$BASE_DIR/.env"
fi

APP_ENV="${APP_ENV:-local}"
MM_CONFIG_FILE=${MM_CONFIG_FILE:-$BASE_DIR/config/config.js}
MM_CUSTOMCSS_FILE=${MM_CUSTOMCSS_FILE:-}
MM_MODULES_DIR=${MM_MODULES_DIR:-$BASE_DIR/modules}
MM_PORT=${MM_PORT:-}

if [ -n "$MM_CONFIG_FILE" ]; then
	MM_CONFIG_FILE=$(realpath "$MM_CONFIG_FILE" || echo)
fi
if [ -n "$MM_CUSTOMCSS_FILE" ]; then
	MM_CUSTOMCSS_FILE=$(realpath "$MM_CUSTOMCSS_FILE" || echo)
fi
if [ -n "$MM_MODULES_DIR" ]; then
	MM_MODULES_DIR=$(realpath "$MM_MODULES_DIR" || echo)
fi

# Not start script responsibility to install dependencies
[ -d node_modules/magicmirror ] || exit 1

export MM_CONFIG_FILE
export MM_MODULES_DIR
export MM_CUSTOMCSS_FILE
export MM_PORT

cd node_modules/magicmirror
exec npm run server
