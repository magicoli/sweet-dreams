# Changelog

## 1.0.0

- MagicMirror² 2.37.0 as an untouched npm dependency, in server-only mode
- installable web app (MMM-PWA module): name and icon, fullscreen, screen kept awake, landscape or portrait
- large clock display
- common config and styles in `resources/`, local personalization in `config/config.js` and `config/custom.css`
- modern CSS (nesting) converted for older tablets
- custom modules in `modules/`, built along with the config
- `npm start` builds and starts the server, `npm run dev` rebuilds and reloads open pages on change
- example configs for Deployer, systemd, supervisor and Caddy
