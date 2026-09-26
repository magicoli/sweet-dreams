import { globSync, statSync } from "node:fs";
import path from "node:path";
import { defineConfig } from "vite";
import { viteStaticCopy } from "vite-plugin-static-copy";

// Builds into MagicMirror's own tree, where it reads config/config.js,
// config/custom.css and modules/:
// resources/ (common) + config/ (local) -> config/, modules/ -> modules/.
export default defineConfig({
	css: {
		// Lowers modern CSS (e.g. nesting) for older browsers like an iPad
		// stuck on an older iPadOS. Default targets: Vite's "baseline widely
		// available" set (Safari/iOS 16.4), set css.lightningcss.targets to
		// go lower.
		transformer: "lightningcss",
	},
	plugins: [
		viteStaticCopy({
			targets: [{ src: "modules", dest: "." }],
		}),
		{
			// vite-plugin-static-copy copies modules/ on every build but only
			// watches it for the dev server, and build.watch.include can only
			// filter the module graph: add the files so `vite build --watch`
			// rebuilds (and re-copies) when a module changes.
			name: "watch-modules",
			buildStart() {
				const root = this.environment.config.root;
				for (const file of globSync("modules/**/*", { cwd: root })) {
					const fullPath = path.resolve(root, file);
					if (statSync(fullPath).isFile()) this.addWatchFile(fullPath);
				}
			},
		},
	],
	build: {
		outDir: "node_modules/magicmirror",
		// MagicMirror's own files live there: never empty it.
		emptyOutDir: false,
		// Readable output: MagicMirror lints config.js and reports errors by line.
		minify: false,
		lib: {
			entry: "resources/main.js",
			formats: ["cjs"],
			fileName: () => "config/config.js",
			cssFileName: "config/custom",
		},
	},
});
