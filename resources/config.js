/* Full config: common settings (common.js) extended by the local
 * config/config.js when it exists (import.meta.glob resolves to nothing for
 * a missing file). Local modules are appended to the common ones.
 */
import common from "./common.js";

const local =
    import.meta.glob("../config/config.js", { eager: true, import: "default" })[
        "../config/config.js"
    ] ?? {};

export default {
    ...common,
    ...local,
    modules: [...common.modules, ...(local.modules ?? [])],
};
