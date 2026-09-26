# Changelog

## 1.1.0 breaking change (refactor)

- refactor as recipe for a standard MagicMirror² install
- new MagicMirror² as a git submodule in `lib/`
- new separate `setup.sh` install script and `run.sh` start script
- new `modules.txt` lists the modules to install
- update PWA features moved to the standalone [MMM-ProgressiveWebApp](https://github.com/magicoli/MMM-ProgressiveWebApp) module: configurable name, colors and icons, service worker covering the whole page
- update config and styles in MagicMirror's own format, examples in `config/`
- update Deployer deploys MagicMirror² itself, systemd only
- removed Vite build, npm packaging and supervisor examples

## 1.0.0

- MagicMirror² 2.37.0 as an untouched npm dependency, in server-only mode
- installable web app (MMM-PWA module): name and icon, fullscreen, screen kept awake, landscape or portrait
- large clock display
- common config and styles in `resources/`, local personalization in `config/config.js` and `config/custom.css`
- modern CSS (nesting) converted for older tablets
- custom modules in `modules/`, built along with the config
- `npm start` builds and starts the server, `npm run dev` rebuilds and reloads open pages on change
- example configs for Deployer, systemd, supervisor and Caddy
