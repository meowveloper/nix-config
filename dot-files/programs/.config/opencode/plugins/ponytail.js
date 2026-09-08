// Adapter for @dietrichgebert/ponytail.
// Ponytail 4.9.0 default-exports a bare v1 server function, but opencode
// >=1.18.29 requires the object form ({ id, setup()/effect(), server() }).
// The v1 server() carries the real behavior (system-prompt injection,
// /ponytail commands, skills paths); setup() only satisfies the v2 check.
import server from "@dietrichgebert/ponytail";

export default {
  id: "@dietrichgebert/ponytail",
  async setup() {},
  server,
};
