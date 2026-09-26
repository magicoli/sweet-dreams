# Sweet Dreams

[![Version](https://img.shields.io/badge/Version-1.0.0-blue)](CHANGELOG.md)
![Stable](https://img.shields.io/github/v/release/magicoli/sweet-dreams?label=Stable)
![GitHub commits since latest release](https://img.shields.io/github/commits-since/magicoli/sweet-dreams/latest?label=Commits%20since)
![Node](https://img.shields.io/badge/NodeJS-22-blue)
[![License](https://img.shields.io/badge/License-AGPL--3.0--or--later-green)](LICENSE)
![GitHub Downloads](https://img.shields.io/github/downloads/magicoli/sweet-dreams/total?label=GitHub%20dl)
![NPM Downloads](https://img.shields.io/npm/dt/sweet-dreams?label=NPM%20dl)

Tablet-based alternative for the legendary Sony Dream Machine ICF-CL70 2009.

Sweet Dreams turns a spare tablet into a bedside clock. A server runs [MagicMirror²](https://magicmirror.builders), and the tablet shows it fullscreen, installed as a web app.

## Features

- Large, elegant clock display, in landscape or portrait
- Any MagicMirror² module: weather, calendar, news feeds, compliments...
- Installable web app: own name and icon, fullscreen, screen kept awake
- Works on older tablets: modern CSS is converted at build time
- Common settings shared by all installs, local personalization kept apart
- MagicMirror² stays an untouched npm dependency, easy to update

## Requirements

- Node.js 22
- A server reachable by the tablet, behind an HTTPS reverse proxy (installing the app and keeping the screen awake both need HTTPS)
- A tablet with a recent browser: Chrome on Android, Safari on iPad

## Installation

```bash
npm install
cp config/config.js.example config/config.js
npm start
```

MagicMirror² is then served on port 8080 (set `MM_PORT` to change it). See [INSTALLATION.md](INSTALLATION.md) for a production server: service, reverse proxy and deployment.

## Tablet setup

Open the site in the tablet's browser, then install it:

- **Android**: Chrome menu, _Add to Home screen_. Prefer Chrome, Samsung Internet may ignore the app name.
- **iPad**: Safari _Share_ menu, _Add to Home Screen_.

Launch it from the home screen icon: it opens fullscreen and keeps the screen awake. Tap the screen once if fullscreen doesn't kick in. Plug the tablet in, it's a clock now.

## Customization

Local settings live in `config/`, not tracked by git:

- `config/config.js`: language, locale and the modules to display, with their positions and options. They are added after the common modules. See [MagicMirror² module configuration](https://docs.magicmirror.builders/modules/configuration.html).
- `config/custom.css`: style overrides, applied after the common styles. Nested CSS is fine.

Common settings and styles live in `resources/`, custom modules in `modules/`. Changes apply on the next `npm start`.

## Roadmap

- adaptive layout for portrait and small screens
- adaptive day/night theme
- customizable background
- customizable alarm sound
- AI integration

## References

- https://github.com/magicmirrororg/magicmirror
