/* Build entry: common resources, extended by the local config/ files when
 * they exist (import.meta.glob resolves to nothing for a missing file). */
import base from "./config.js";

// Both as globs: Vite hoists glob imports above static ones, which would put
// the local overrides before the common styles and let the common ones win.
import.meta.glob("./custom.css", { eager: true });
import.meta.glob("../config/custom.css", { eager: true });

const local = import.meta.glob("../config/config.js", {
    eager: true,
    import: "default",
});

export default local["../config/config.js"] ?? base;
