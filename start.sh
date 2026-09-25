#!/bin/sh
# Wires our own files into the untouched magicmirror/ submodule, then starts
# MagicMirror in server-only mode (no Electron/display needed in the container).
set -e

ln -sfn ../../config/config.js magicmirror/config/config.js

for dir in modules/*/; do
	[ -d "$dir" ] || continue
	name=$(basename "$dir")
	ln -sfn "../../modules/$name" "magicmirror/modules/$name"
done

cd magicmirror
[ -d node_modules ] || npm run install-mm
exec npm run server
