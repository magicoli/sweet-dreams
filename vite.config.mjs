import { defineConfig } from "vite";

// resources/ (common) + config/ (local) -> node_modules/magicmirror/config/,
// the location MagicMirror reads config.js and custom.css from.
export default defineConfig({
	build: {
		outDir: "node_modules/magicmirror/config",
		// Shared with files MagicMirror writes itself (basepath.js).
		emptyOutDir: false,
		// Readable output: MagicMirror lints config.js and reports errors by line.
		minify: false,
		lib: {
			entry: "resources/main.js",
			formats: ["cjs"],
			fileName: () => "config.js",
			cssFileName: "custom",
		},
	},
});
