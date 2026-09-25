# Installation

## Node.js

See [Instructions for any platforms](https://nodejs.org/en/download)
Make sure to select node 22 in the choices.

Example for Linux:

```bash
# Download and install nvm:
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.8/install.sh | bash

# in lieu of restarting the shell
\. "$HOME/.nvm/nvm.sh"

# Download and install Node.js:
nvm install 22

# Verify the Node.js version:
node -v # Should print "v22.23.3".

# Verify npm version:
npm -v # Should print "10.9.9".
```

## Config

MagicMirror's config is a server-specific setting, not part of the repo or the deploy. Create it once per environment:

```bash
cp config/config.js.example config/config.js
```

Edit it for the real location, weather provider, etc.

## Supervisor

Copy `etc/supervisor/conf.d/sweet-dreams.conf.example` to your real supervisor config directory (see `etc/README.md` for this server's convention), then fill in:
- `directory`: the deploy path's `current/` (e.g. `~/domains/sweet-dreams.magiiic.com/app/current`)
- `user`: the deploy user
- `environment`: `PATH=` needs the real node/npm bin directory prepended. Supervisor doesn't spawn through a login shell, so it never sees a PATH nvm/fnm sets up in `.bashrc`. Find yours with `nvm which 22` (strip the trailing `/node`).

By default `supervisorctl` needs root. Rather than granting broad sudo, give the deploy user access to supervisor's own control socket instead (in `supervisord.conf`'s `[unix_http_server]` section: `chmod=0770` + `chown=<user>:<group>`) - then `supervisorctl restart sweet-dreams` works directly, no sudo involved.

```bash
sudo supervisorctl reread
sudo supervisorctl update
```

## Caddy

Copy `etc/caddy/sweet-dreams.caddyfile.example` to your real Caddy sites directory, filling in the real domain. It's a plain reverse proxy to the Node process - no docroot, MagicMirror serves everything itself.

## First deploy

`config/config.js` is a Deployer `shared_file` (see `deploy.maml`), symlinked into every release from `shared/` - but since it's not in the repo, there's nothing for Deployer to seed it from on a brand new host. Before the first `dep deploy`, create it by hand:

```bash
mkdir -p {{deploy_path}}/shared/config
cp config/config.js.example {{deploy_path}}/shared/config/config.js
```

Then edit that file for the real deployment (location, weather provider, etc.), same as the local `config/config.js` above.

