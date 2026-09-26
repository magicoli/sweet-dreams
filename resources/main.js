/* Build entry: config and styles, common resources extended by the local
 * config/ files when they exist. */

// Both as globs: Vite hoists glob imports above static ones, which would put
// the local overrides before the common styles and let the common ones win.
import.meta.glob("./custom.css", { eager: true });
import.meta.glob("../config/custom.css", { eager: true });

export { default } from "./config.js";
