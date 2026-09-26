#!/bin/sh
# Installs MagicMirror² in lib/ with the modules listed in modules.txt, and
# creates its config and styles from config/ when missing.

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

update_env() {
	local key=$1
	shift
	value="$@"
	if echo "$value" | grep -q "[^a-zA-Z0-9_-]"; then
		value="\"$value\""
	fi
	[ -n "${ENV_FILE:-}" ] || ENV_FILE="$BASE_DIR/.env"
	[ -f "$ENV_FILE" ] || touch $ENV_FILE
	if egrep -q "^${key}=($value|\"$value\"|'$value')$" $ENV_FILE; then
		# log "  no change for ${key}, skipping"
		return
	elif egrep -q "^[# ]*${key}=" $ENV_FILE; then
		sed -i~ "s+^[# ]*${key}=.*+${key}=${value}+" $ENV_FILE &&
			log "  updated ${key} in $ENV_FILE" &&
			return ||
			log "[ERROR] could update $key in $ENV_FILE"
	else
		echo "${key}=\"${value}\"" >>$ENV_FILE &&
			log "  added ${key} to $ENV_FILE" &&
			return ||
			log "[ERROR] could not add $key to $ENV_FILE"
	fi
	return $?
}

if [ -f ~/.nvm/nvm.sh ]; then
	. ~/.nvm/nvm.sh
fi

if [ -f "$BASE_DIR/.env" ]; then
	. "$BASE_DIR/.env"
fi

APP_NAME=${APP_NAME:-"Sweet Dreams"}
APP_ENV="${APP_ENV:-local}"
update_env APP_ENV "$APP_ENV"
update_env APP_NAME "$APP_NAME"

if [ -n "${APP_ENV:-}" -a "${APP_ENV}" != "production" ]; then
	APP_NAME="$APP_NAME (${APP_ENV})"
fi
log "Setup ${APP_NAME} MagicMirror²"
log "Base dir: $MM_BASE_DIR"
log "MagicMirror² dir: $MM_BASE_DIR"
log "Node version: $(node -v)"

export MM_CONFIG_FILE=${MM_CONFIG_FILE-${MM_BASE_DIR}/config/config.js}
export MM_CUSTOMCSS_FILE=${MM_CUSTOMCSS_FILE-${MM_BASE_DIR}/config/custom.css}
export MM_MODULES_DIR=${MM_MODULES_DIR-${MM_BASE_DIR}/modules}
export MM_PORT=${MM_PORT:-8080}

update_env MM_CONFIG_FILE "$MM_CONFIG_FILE"
update_env MM_CUSTOMCSS_FILE "$MM_CUSTOMCSS_FILE"
update_env MM_MODULES_DIR "$MM_MODULES_DIR"
update_env MM_PORT "$MM_PORT"

log "  port:    $MM_PORT"

log Update submodules

git submodule sync
git submodule update --init

log Install MagicMirror²
cd $MM_BASE_DIR
npm run install-mm

if [ ! -f "$BASE_DIR/modules.txt" ]; then
	log Create modules.txt from example
	cp "$BASE_DIR/modules.txt.example" "$BASE_DIR/modules.txt"
fi

log Install modules listed in modules.txt
grep -v '^[[:space:]]*#' "$BASE_DIR/modules.txt" | while read -r url; do
	[ -n "$url" ] || continue
	dir="$MM_MODULES_DIR/$(basename "$url" .git)"
	[ -d "$dir" ] || git clone "$url" "$dir"
	# Some modules have their own dependencies.
	! grep -qs '"dependencies"' "$dir/package.json" || (cd "$dir" && npm install --omit=dev)
done

cd $MM_BASE_DIR

if [ -f "$MM_CONFIG_FILE" ]; then
	log Config file found, skipping config.js creation
else
	log Creating config.js from example
	if [ -f "$BASE_DIR/config/config.js" ]; then
		log Copy $BASE_DIR/config/config.js to $MM_CONFIG_FILE
		cp $BASE_DIR/config/config.js "$MM_CONFIG_FILE"
	else
		log Create new config.js from $BASE_DIR/config/config.js.example
		cp $BASE_DIR/config/config.js.example "$MM_CONFIG_FILE"
	fi
fi

if [ -f "$MM_CUSTOMCSS_FILE" ]; then
	log custom.css found, skipping custom.css creation
else
	if [ -f "$BASE_DIR/config/custom.css" ]; then
		log Copy $BASE_DIR/config/custom.css to $MM_CUSTOMCSS_FILE
		cp $BASE_DIR/config/custom.css "$MM_CUSTOMCSS_FILE"
	else
		log Create new custom.css from example
		cp $BASE_DIR/config/custom.css.example "$MM_CUSTOMCSS_FILE"
	fi
fi

log Installation completed. Customize in $MM_BASE_DIR
cd $MM_BASE_DIR
log "config: $(realpath $MM_CONFIG_FILE)"
log "css: $(realpath $MM_CUSTOMCSS_FILE)"
log "modules: $(realpath $MM_MODULES_DIR)"
log "port: $MM_PORT"

log "run ./run.sh to start the server"
