// Makes MagicMirror installable as a fullscreen home-screen app and keeps the
// display awake, without touching the magicmirror/ submodule: everything is
// injected from here (head tags, service worker, wake lock).
Module.register("MMM-PWA", {
	start() {
		this.injectHead();
		this.registerServiceWorker();
		this.requestWakeLock();

		document.addEventListener("visibilitychange", () => {
			if (document.visibilityState === "visible") this.requestWakeLock();
		});
	},

	// No visible UI of its own.
	getDom() {
		return document.createElement("div");
	},

	injectHead() {
		const link = document.createElement("link");
		link.rel = "manifest";
		link.href = "/modules/MMM-PWA/manifest.json";
		document.head.appendChild(link);

		// iOS/iPadOS installability still relies on these rather than manifest.json alone.
		const appleTags = [
			["apple-mobile-web-app-capable", "yes"],
			["apple-mobile-web-app-status-bar-style", "black-translucent"],
			["apple-mobile-web-app-title", "Sweet Dreams"]
		];
		for (const [name, content] of appleTags) {
			const meta = document.createElement("meta");
			meta.name = name;
			meta.content = content;
			document.head.appendChild(meta);
		}

		const appleIcon = document.createElement("link");
		appleIcon.rel = "apple-touch-icon";
		appleIcon.href = "/modules/MMM-PWA/icons/apple-touch-icon.png";
		document.head.appendChild(appleIcon);

		const themeColor = document.createElement("meta");
		themeColor.name = "theme-color";
		themeColor.content = "#0b0b10";
		document.head.appendChild(themeColor);
	},

	registerServiceWorker() {
		if (!("serviceWorker" in navigator)) return;
		// scope: "/" so it covers the actual page (start_url), not just its own
		// /modules/MMM-PWA/ directory - needs the Service-Worker-Allowed header
		// set by the reverse proxy, since the script itself isn't served from root.
		navigator.serviceWorker.register("/modules/MMM-PWA/sw.js", { scope: "/" }).catch((error) => {
			Log.error("MMM-PWA: service worker registration failed", error);
		});
	},

	requestWakeLock() {
		if (!("wakeLock" in navigator)) return;
		navigator.wakeLock.request("screen").catch((error) => {
			Log.error("MMM-PWA: wake lock request failed", error);
		});
	}
});
