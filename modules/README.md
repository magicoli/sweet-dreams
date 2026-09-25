# Custom MagicMirror modules

MagicMirror² itself lives untouched in the `magicmirror/` submodule. Modules here
get symlinked into `magicmirror/modules/` at container start (see `start.sh`),
following the same pattern any third-party module install would use, so upstream
stays pristine and pullable.
