# ripple-ark

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
