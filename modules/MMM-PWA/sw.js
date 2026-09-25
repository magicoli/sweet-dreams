// Network-first, cache-on-success shell. No hardcoded file list, so it keeps
// working across MagicMirror upstream changes; only smooths over brief drops,
// live module data still goes straight to the network.
const CACHE_NAME = "sweet-dreams-shell-v1";

self.addEventListener("install", () => {
	self.skipWaiting();
});

self.addEventListener("activate", (event) => {
	event.waitUntil(self.clients.claim());
});

self.addEventListener("fetch", (event) => {
	if (event.request.method !== "GET") return;

	event.respondWith(
		fetch(event.request)
			.then((response) => {
				const copy = response.clone();
				caches.open(CACHE_NAME).then((cache) => cache.put(event.request, copy));
				return response;
			})
			.catch(() => caches.match(event.request))
	);
});
