import { defineConfig } from "tsup";

export default defineConfig({
  clean: true,
  entry: ["src/index.ts"],
  external: [/^@zag-js\//, "@celados/ripple-zag", "ripple"],
  format: ["esm", "cjs"],
  minify: true,
  target: "es2020",
  treeshake: "smallest",
});
