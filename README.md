# Sweet Dreams

![Stable](https://img.shields.io/github/release/magicoli/sweet-dreams?label=stable&color=green&include_prereleases)
![GitHub Tag](https://img.shields.io/github/tag/magicoli/sweet-dreams?label=latest&include_prereleases)
![GitHub commits since latest release](https://img.shields.io/github/commits-since/magicoli/sweet-dreams/latest?label=dev)
![Node](https://img.shields.io/badge/node.js-22-blue)
[![License](https://img.shields.io/badge/license-AGPL--3.0-552b55)](LICENSE)
![GitHub Downloads (all assets, all releases)](https://img.shields.io/github/downloads/magicoli/sweet-dreams/total)

Tablet-based alternative for the legendary Sony Dream Machine ICF-CL70 2009.

Sweet Dreams turns a spare tablet into a bedside clock. It is a recipe for a standard [MagicMirror²](https://magicmirror.builders) install: the [MMM-ProgressiveWebApp](https://github.com/magicoli/MMM-ProgressiveWebApp) module shows it fullscreen on the tablet, installed as an app, and this repo provides a ready-made config and styles.

## Features

- Large, elegant clock display, in landscape or portrait
- Any MagicMirror² module: weather, calendar, news feeds, compliments...
- Installable app: own name and icon, fullscreen, screen kept awake
- Plain MagicMirror² install, updated the usual way

## Requirements

- Node.js 22
- A server reachable by the tablet, behind an HTTPS reverse proxy (installing the app and keeping the screen awake both need HTTPS)
- A tablet with a recent browser: Chrome on Android, Safari on iPad

## Installation

Install MagicMirror² and the modules listed in `modules.txt`:

```bash
./setup.sh
```

Then start it from the MagicMirror folder:

```bash
cd lib/MagicMirror
npm run server
```

MagicMirror² is then served on port 8080 by default, open http://localhost:8080. See [INSTALLATION.md](INSTALLATION.md) for a production server: service, reverse proxy and deployment.

## Tablet setup

Open the site in the tablet's browser, then install it:

- **Android**: Chrome menu, _Add to Home screen_. Prefer Chrome, Samsung Internet may ignore the app name.
- **iPad**: Safari _Share_ menu, _Add to Home Screen_.

Launch it from the home screen icon: it opens fullscreen and keeps the screen awake. Tap the screen once if fullscreen doesn't kick in. Plug the tablet in, it's a clock now.

## Customization

Everything lives in MagicMirror's `config/` folder:

- `config/config.js`: language, locale and the modules to display, with their positions and options. See [MagicMirror² module configuration](https://docs.magicmirror.builders/modules/configuration.html).
- `config/custom.css`: styles. Stick to plain CSS (no nesting), older tablets don't support it.

Third-party modules, like [alternative clocks](https://modules.magicmirror.builders/?search=clock), go in `modules/`. Restart the server after a change, or run `npm run server:watch` to restart it automatically.

## Roadmap

- adaptive layout for portrait and small screens
- adaptive day/night theme
- customizable background
- customizable alarm sound
- AI integration

## References

- https://github.com/MagicMirrorOrg/MagicMirror
- https://github.com/magicoli/MMM-ProgressiveWebApp
