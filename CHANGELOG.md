# ripple-ark

## 0.3.2

- Keep render-prop API and item contexts live as their Zag machine state changes.
- Preserve children for rootless provider components such as Dialog, Menu, Popover, and Tooltip.
- Forward part-specific props and merge all inherited contexts required by Image Cropper and Color Picker.

## 0.3.1

- Preserve reactive public props through generated roots, parts, providers, and utility components.
- Replace callback children with explicit `render` props so Ripple renders returned TSRX nodes.
- Keep `ClientOnly` represented in SSR output so post-hydration content mounts reliably.

## 0.3.0

- Generate native static TSRX tags for Ark parts instead of making every component polymorphic.
- Remove the parallel `demos` and `demo-sources` package interfaces; Ripple Explore now consumes
  the actual compound component bindings.
- Remove the accidentally committed npm tarball.

## 0.2.6

- Annotate module-scope factory calls as pure so bundlers can tree-shake unused
  components; importing one component no longer drags every Zag machine into
  the consumer bundle.

## 0.2.5

- Verify published packages with the TypeScript major currently supported by TSRX.

## 0.2.4

- Stop requiring consumers to enable `allowImportingTsExtensions` for package-internal modules.
- Add a clean TSRX TypeScript consumer gate before publishing.

## 0.2.3

- Regenerate published demo source text after the Ark adapter migration and guard it against drift.

## 0.2.2

- Verify the published TSRX source from an explicit Vite entry in a clean registry consumer.

## 0.2.1

- Make source-package verification portable to the organization release runner.

## 0.2.0

- Replace the hooks-only facade with Ark-style Ripple compound components for every current
  official Solid component directory and namespace part.
- Move all 49 ripple-explore demos into this package and upgrade them for current Zag APIs and TSRX
  syntax.
- Add Ripple-native `ark`, locale, environment, interaction, presence, field, fieldset, frame,
  format, swap, toast, and tree utilities.
- Publish source `.tsrx` subpaths and verify every machine component through a clean Vite consumer.
- Add ESLint and Prettier gates using the TSRX plugins.

## 0.1.1

- Publish portable, non-bundled TypeScript declarations.
- Depend on the corrected `@celados/ripple-zag@0.4.1` element prop types.
- Verify the packed package with a clean TypeScript consumer in CI.

## 0.1.0

- Add Ripple-native hooks for all 49 current Zag component machines.
- Include the new Date Input, Drawer, Marquee, Navigation Menu, and Toggle bindings.
- Add named collection, parsing, toast-store, and nested-service capabilities used by
  real Ripple consumers without re-exporting Zag namespaces.
