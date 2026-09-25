/* Common Sweet Dreams config: only what differs from MagicMirror's own
 * defaults (node_modules/magicmirror/js/defaults.js). Local personalization
 * goes in config/config.js, which imports and extends this.
 */
export default {
	// 0.0.0.0 so the reverse proxy in front of MagicMirror can reach it.
	address: "0.0.0.0",
	// Access control is handled by the reverse proxy, not by MagicMirror.
	ipWhitelist: [],

	// Watched by `npm run dev` (MagicMirror's server:watch) to restart the
	// server. Relative to node_modules/magicmirror, where the build writes.
	watchTargets: ["config/config.js", "config/custom.css"],

	// Pages reload once the restarted server is back (dev changes, deploys).
	// server:watch's own RELOAD signal is sent to the server it is about to
	// kill, so it rarely reaches the browser.
	reloadAfterServerRestart: true,
	checkServerInterval: 5 * 1000,

	modules: [
		{ module: "MMM-PWA" },
	],
};
