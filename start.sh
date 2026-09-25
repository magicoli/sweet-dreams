#!/bin/sh
# Wires our own files into the untouched magicmirror npm package, then starts
# MagicMirror in server-only mode (no Electron/display needed in the container).
set -e

[ -d node_modules ] || npm install --omit=dev

MM=node_modules/magicmirror
mkdir -p "$MM/config" "$MM/modules"
ln -sfn ../../../config/config.js "$MM/config/config.js"

for dir in modules/*/; do
	[ -d "$dir" ] || continue
	name=$(basename "$dir")
	ln -sfn "../../../modules/$name" "$MM/modules/$name"
done

cd "$MM"
exec npm run server
