---
name: upstream-sync
description: >
  Regenerating or syncing the Ark → Ripple bindings against a fresh
  chakra-ui/ark or zag release, adding a new component, or changing
  scripts/generate-bindings.ts. Covers what is mechanically translatable, what
  must be hand-ported, and the gates a sync must pass before release.
---

# Upstream sync: Ark (Solid) → Ripple bindings

The generator translates the Ark Solid adapter into Ripple TSRX. Translation is
**not** 100% mechanical, and treating it as such ships silently dead components.
Every sync decision routes through this taxonomy:

| Class                    | What                                                                            | Handled by                                                                                     |
| ------------------------ | ------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| (a) Declarative surface  | tag + `getXxxProps` getter + prop keys + context chains                         | uniform template — mechanical, trust the generator                                             |
| (b) Imperative semantics | effects, nested-machine wiring, derived children, presence, inverted structures | `partOverrides` / `rootOverrides` / `specialDeclarations` — hand-ported, one entry per case    |
| (c) Hook-layer injection | `id`, `dir`, `getRootNode` per instance                                         | `createMachineHook` (`src/create-machine.ts`) — one shared implementation, never per-component |

## Layout

- `.scratch/ark-upstream/` — Ark snapshot; `packages/solid/src/components/` is the behavior source of truth. Refresh via
  `curl -fsSL "https://codeload.github.com/chakra-ui/ark/tar.gz/main" | tar -xz -C .scratch/ark-upstream --strip-components=1`
- `scripts/generate-bindings.ts` — parser + declarative maps + templates. All generated-code changes go here, never into `src/generated/*` by hand.
- `src/binding-runtime.tsrx` — shared runtime (`useRootProps`, `usePartProps`, `useRootPresence`, `createApiContext`, `createItemContext`). Extend, don't fork per component.
- `src/generated/presence.tsrx`, `src/generated/cascade-select.tsrx` — hand-written residents the generator preserves in `index.ts` but never writes.
- `src/components.ts` — one `useXxx` hook per zag machine; hooks cannot import generated files (cycle), which is why component-scoped context wiring lives in generated overrides instead.

## Generator maps (edit these, in this order of preference)

| Map                                                                        | Use when                                                                                                                                                                                                                                                                 |
| -------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| `hookOverrides` / `machinePackageOverrides`                                | component dir ≠ machine name (e.g. segment-group → radio-group)                                                                                                                                                                                                          |
| `presencePartBehaviors`                                                    | a part consumes `usePresenceContext` upstream; record its behaviors (`gate` / `mergePresence` / `presenceRef` / trigger `ariaControls`) per what the upstream file actually does — a drift assertion fails the build when the upstream file set diverges from this table |
| `partOverrides`                                                            | one part's body needs class-(b) semantics; value is the full TSRX body                                                                                                                                                                                                   |
| `rootOverrides` / `rootProviderOverrides`                                  | the Root itself deviates (menu nesting, tour instance contract)                                                                                                                                                                                                          |
| `typeOverrides` / `rootPropsTypeOverrides`                                 | an override changes the honest public prop type                                                                                                                                                                                                                          |
| `specialPrelude` / `specialDeclarations` / `specialNames` / `extraImports` | extra module-scope contexts, ported hooks, or additional exports                                                                                                                                                                                                         |
| `gateExceptions`                                                           | a component legitimately fails the zag-props gate; requires a reason string                                                                                                                                                                                              |
| `skipped`                                                                  | the component is hand-written under `src/utilities/` instead                                                                                                                                                                                                             |

## Composition contract

Parts compose via Base UI's **function-form `render` prop only** (README "Composition").
Never port Ark/Radix `asChild`, an `as` prop, or Base UI's element-form `render={<X />}`
from upstream — strip them when syncing; `splitProps` drops `render` globally so it can
never leak to the DOM or a machine.

All element rendering routes through binding-runtime's **`Part` frame**: it owns the
render branch, presence gate, composed ref (`createRefKey()` symbol entry so a plain
spread carries it), and void-tag handling. Generated declarations state only what varies
— `tag`, `options={...}` (Part runs `usePartProps`) or `merged={...}` (bespoke bodies
precompute the Tracked), `gate`/`composeRef` flags, children. Never emit inline
render/presence branches in a template or override — extend `Part` instead.

## Sync procedure

1. Refresh the upstream snapshot; bump `@zag-js/*` deps with the package manager (never hand-write versions).
2. `bun run generate:bindings`. The generator hard-fails on: zag-props gate violations (`verifyZagProps` — extracted `configKeys` must cover the machine's own `props` export minus `dir`/`getRootNode`) and presence-table drift.
3. For each gate failure or new upstream file, read the upstream source and classify (a)/(b)/(c) before touching any map. The class-(b) smells, any of which mean the uniform template will silently degrade the part:
   - `createEffect` / `onMount` / `onCleanup` (listeners, object URLs, machine wiring)
   - `<Show when={...}>` or other conditional rendering
   - children fallback to machine-derived text (`{props.children || api().xxx}`)
   - context use beyond the `PropsProvider`/`PropsContext` pair
   - a part that wraps _outside_ Root or receives a machine instance as a prop
4. `bun run verify` plus the runtime smoke suite (`tests/smoke.test.ts`). Name-level parity, typecheck, and SSR pack all pass on behaviorally dead components — any new structural fix needs a smoke assertion that fails on the pre-fix code, driven through the public api (`Context` render prop / `RootProvider`) rather than synthetic pointer events where possible.
5. Diff `src/generated/` and read every changed override output against its upstream file. Regenerated declarative parts need only spot checks.
6. Accepted gaps go to `.agents/backlog.md` with reasoning, same entry style as the existing ones.

## Traps

- Regex extraction only sees the declarative surface. It cannot see imperative code — that is precisely why class (b) exists. Never "fix" a class-(b) gap by making the parser smarter.
- Solid `props` and generated reactive-props objects carry live getters: spreading them freezes a snapshot. Compose with getters (`withDefaults`, `createReactiveProps`) or inside `track()`.
- Inside `track()` callbacks, read `.value` in the callback itself; hoisting a dereferenced value outside freezes it and kills the subscription.
- `Context.get()`/`set()` need an active component: call at setup or inside computations created during setup. Hoist `context.get()` out of `effect()` bodies.
- Zag's `mergeProps` composes handlers/class/style; a plain object spread clobbers machine behavior. Mind upstream's merge _order_ per file — upstream itself is not uniform.
- Presence keys (`PRESENCE_KEYS`) must be omitted from DOM-bound local props on every presence Root, or they leak as attributes.
- One `ripple` runtime per test process. Vitest externalizes node_modules deps, so ripple-zag's dist resolves `ripple` through Node (server build, its own scheduler) while the mounted tree uses the vite browser build — machines then register mount effects nothing flushes and silently drop every event. `vitest.config.ts` pins this with `server.deps.inline` + `resolve.dedupe`; a "passes locally, fails in CI" smoke split means the local `node_modules` layout is lying — reproduce with `rm -rf node_modules && bun install --frozen-lockfile` before debugging anything else.
