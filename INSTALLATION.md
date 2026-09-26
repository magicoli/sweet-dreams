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

## MagicMirror² and config

Install MagicMirror², the MMM-ProgressiveWebApp module and the Sweet Dreams config as described in [README.md](README.md#installation). Edit `config/config.js` for the real location, weather provider, modules, etc.

See the [MagicMirror² documentation](https://docs.magicmirror.builders/getting-started/installation.html) for other install and update methods.

## Service

### systemd

Copy `etc/systemd/system/sweet-dreams.service.example` to `/etc/systemd/system/sweet-dreams.service`, then fill in:

- `User`: the user owning the MagicMirror folder
- `WorkingDirectory`: the MagicMirror folder, or the deploy path's `current/` (e.g. `~/domains/example.com/app/current`, expanded)
- `Environment=PATH=`: the real node/npm bin directory first. systemd doesn't spawn through a login shell, so it never sees a PATH nvm sets up in `.bashrc`. Find yours with `nvm which 22` (strip the trailing `/node`)

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now sweet-dreams
```

Run `daemon-reload` again after each change to the unit file.

### supervisor

If you already use supervisor, copy `etc/supervisor/conf.d/sweet-dreams.conf.example` to supervisor's config directory instead, and fill in `directory`, `user` and `environment` the same way.

```bash
sudo supervisorctl reread
sudo supervisorctl update
```

## Caddy

Copy `etc/caddy/sweet-dreams.caddyfile.example` to your real Caddy sites directory, filling in the real domain. It's a plain reverse proxy to the Node process - no docroot, MagicMirror serves everything itself. HTTPS is required to install the app on tablets and keep their screen awake.

## Deployment

Updating a plain install is `git pull && npm run install-mm` in the MagicMirror folder, and `git pull` in each module folder.

[Deployer](https://deployer.org) can deploy MagicMirror² itself instead: copy `deploy.maml.example` to `deploy.maml` and fill in the host and paths. Each deploy fetches MagicMirror's latest release, runs `npm run install-mm`, then restarts the service (`sudo` must not ask for a password for that command).

`config/` and `modules/` are shared between releases, in `shared/`. After the first `dep deploy`, add the Sweet Dreams files and the MMM-ProgressiveWebApp module there:

```bash
cp config/config.js.example {{deploy_path}}/shared/config/config.js
cp config/custom.css.example {{deploy_path}}/shared/config/custom.css
cp config/sweet-dreams-*.png {{deploy_path}}/shared/config/
git clone https://github.com/magicoli/MMM-ProgressiveWebApp.git {{deploy_path}}/shared/modules/MMM-ProgressiveWebApp
```

Then edit `config.js` for the real deployment and restart the service.
