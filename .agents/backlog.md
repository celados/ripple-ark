# Deferred work log

Known tails accepted with reasoning. Remove entries when resolved.

## Field ↔ control integration (deferred 2026-08-11)

Upstream Ark wires `useFieldContext` into ~13 machine hooks (checkbox, select, combobox, editable, number-input, password-input, pin-input, rating-group, signature-pad, switch, tags-input, color-picker, file-upload): field ids map into machine `ids`, and `disabled`/`readOnly`/`invalid`/`required` plus `ariaDescribedby` flow into controls and hidden inputs. Our `field.tsrx` utility exists but keeps its context module-private, and generated components never consume it. Fix needs (1) `field.tsrx` exposing a consumable context contract, (2) a per-component ids/props mapping table in the generator or hook layer. Until then `Field.Root` + control composition renders but lacks the aria/ids/state wiring.

## Part composition: function-form `render` prop, not asChild (decision 2026-08-11, unimplemented)

Do NOT port Ark/Radix `asChild` (child cloning + slot merging) or an `as` prop (polymorphic
type tarpit). Adopt Base UI's composition model (https://base-ui.com/react/handbook/composition)
in its function form only: every part accepts `render?: (props: MergedProps) => Children`,
implemented as one uniform template branch (`<{Content} />`) in the generator. Merged props must
pass through `createReactiveObject` so reads stay live across the single render call — same
mechanism `Context`/`ItemContext` already use. Base UI's element form (`render={<MyButton />}`)
is a React idiom; skip it. The fully headless escape hatch already exists and stays primary:
hooks + zag getters (`useDialog().value.getTriggerProps()`) and `Xxx.Context` render props.
`src/factory.tsrx`'s `asChild` becomes dead surface once this lands — remove it then.

## ripple must be a peerDependency (2026-08-11)

The 0.4.0 CI failure's root packaging error: ripple is a module-global singleton runtime
(scheduler, `active_component`), but ripple-zag declares it as a regular `dependency` and
ripple-ark only as a devDependency. Any layout that loads two copies (nesting, dual
browser/node builds across an externalization boundary) silently splits the reactive graph —
computeds half-work, effects never flush. Fix: ripple-ark declares `ripple` as a
peerDependency next release; file the same against ripple-zag (transfer alongside issue #2);
consider proposing a double-instance sentinel warning to ripple upstream.

## Complex derived-content parts (deferred 2026-08-11)

`DatePicker.ValueText` (render-prop per value, separator/placeholder semantics) and `ColorPicker.ChannelSliderValueText` (locale-formatted channel text via channel props context) were skipped by the derived-content fallback pass — both need bespoke bodies, not the shared fallback template. They currently render children only.

## Checkbox group integration lives at Root, not hook (trade-off 2026-08-11)

Upstream merges group item props inside `useCheckbox`; our hooks (`components.ts`) cannot import generated per-component contexts without a cycle, so the group merge happens in the generated `Checkbox.Root`. Consequence: direct `useCheckbox()` users do not get `Checkbox.Group` integration. Revisit if the hook layer ever grows per-component adapters.

## ripple-zag: useMachine still crashes without id (external, 2026-08-11)

Issue #2's root fix belongs in `@celados/ripple-zag` `useMachine` (auto id fallback). ripple-ark now injects ids in `createMachineHook`, which resolves it for all ark components, but direct ripple-zag consumers still crash. Transfer the issue once ripple-zag has issues enabled.
