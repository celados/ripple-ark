# Deferred work log

Known tails accepted with reasoning. Remove entries when resolved.

## SSR/hydration-stable machine ids need a ripple-level useId (deferred 2026-08-11)

`createMachineHook`'s auto id is a module-global counter: stable per instance lifetime,
but a long-lived SSR process keeps counting across requests while each client load starts
from 1, so hydrated DOM ids drift from the machine scope (`dialog:ark-5:content` server
vs `dialog:ark-1:content` client; empirically confirmed by double-SSR during the 0.5.x
codex review). A real fix needs tree-position-stable id generation from ripple itself
(React useId equivalent); nothing ripple-ark can fake locally. Until then SSR consumers
must pass explicit `id`s.

## Field ↔ control integration (deferred 2026-08-11)

Upstream Ark wires `useFieldContext` into ~13 machine hooks (checkbox, select, combobox, editable, number-input, password-input, pin-input, rating-group, signature-pad, switch, tags-input, color-picker, file-upload): field ids map into machine `ids`, and `disabled`/`readOnly`/`invalid`/`required` plus `ariaDescribedby` flow into controls and hidden inputs. Our `field.tsrx` utility exists but keeps its context module-private, and generated components never consume it. Fix needs (1) `field.tsrx` exposing a consumable context contract, (2) a per-component ids/props mapping table in the generator or hook layer. Until then `Field.Root` + control composition renders but lacks the aria/ids/state wiring.

## Presence composed ref doesn't forward a user ref's cleanup (deferred 2026-08-11)

`applyPresenceRef` (generate-bindings.ts, `presencePartDeclaration`) composes
`presence.value.setNode(node)` with the caller's own `ref(node)` but never returns a
cleanup function. Ripple's `ref()` binder (`.scratch/ripple-upstream/packages/ripple/
src/runtime/internal/client/blocks.js`) only calls a _returned_ function as cleanup on
unmount — it never re-invokes a callback ref with `null` — so a caller whose own `ref`
prop returns its own cleanup (e.g. removing a listener it added in the ref callback)
never gets that cleanup run on a presence-gated part. This is pre-existing (the static
branch had the identical composed-callback shape before the render-prop migration) and
applies to both branches equally; discovered while verifying the render migration's ref
contract, not introduced by it. Fix: `applyPresenceRef` should call the user's `ref` and
return a function that invokes whatever the user's `ref` itself returned.

## Complex derived-content parts (deferred 2026-08-11)

`DatePicker.ValueText` (render-prop per value, separator/placeholder semantics) and `ColorPicker.ChannelSliderValueText` (locale-formatted channel text via channel props context) were skipped by the derived-content fallback pass — both need bespoke bodies, not the shared fallback template. They currently render children only.

## Checkbox group integration lives at Root, not hook (trade-off 2026-08-11)

Upstream merges group item props inside `useCheckbox`; our hooks (`components.ts`) cannot import generated per-component contexts without a cycle, so the group merge happens in the generated `Checkbox.Root`. Consequence: direct `useCheckbox()` users do not get `Checkbox.Group` integration. Revisit if the hook layer ever grows per-component adapters.

## ripple-zag: useMachine still crashes without id (external, 2026-08-11)

Issue #2's root fix belongs in `@celados/ripple-zag` `useMachine` (auto id fallback). ripple-ark now injects ids in `createMachineHook`, which resolves it for all ark components, but direct ripple-zag consumers still crash. Transfer the issue once ripple-zag has issues enabled.

## Issue #6 not reproducible in-repo; needs an app-side repro (deferred 2026-08-12)

`tests/machine-reactivity.test.ts` covers both reported symptoms at the exact reported
versions (ripple-ark 0.6.0 / ripple-zag 0.4.1 / @zag-js/* 1.43.0 / ripple 0.3.118) across
9 shapes — controlled `open` as Tracked box and as raw value, driven both from the initial
state and after a trigger-initiated open; Escape and outside-press entering "open" at mount
and via transition; and a co-mounted standing dismissable layer. All pass, so neither
symptom is an adapter defect on any path the harness can reach. One real mechanism was
found and characterized (a layer mounted above an open menu deafens Escape by
`@zag-js/dismissable`'s `isTopMost` gate) but it is upstream, framework-agnostic behavior
and does not explain the reported outside-press failure. The reporting app's Menu usage
was never committed, so no failing code survives to bisect. Reopen with a runnable repro
that states dev-server vs built-dist and browser.
