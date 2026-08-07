# ripple-ark

This repository is the Ripple-native binding layer for Zag component machines.
It owns machine startup, Ripple tracking, prop normalization, and a small set of
component-domain constructors. Markup, content, icons, and styles belong to consumers.

## Commands

Use Bun: `bun install`, `bun run typecheck`, `bun run test`, and `bun run build`.
Every release must pass a clean-consumer compile against the packed artifact.

## Boundaries

- Add one `useXxx` hook for every component machine in the current Zag catalog.
- Keep Zag machines and generic utilities behind this package. Export a named helper
  only when a real Ripple consumer needs that component-domain capability.
- Hooks return a tracked connected API. The attached `service` exists for nested
  parent/child machines; ordinary consumers should use `api.value`.
- Static TSRX text is native JSX text. Use expressions for dynamic values and for
  parser-required escapes such as whitespace-only nodes.
- Comments explain the adapter constraint or trade-off, not the code operation.

## Current sources

Read these before changing integration behavior:

- https://www.ripple-ts.com/llms.txt
- https://zagjs.com/llms.txt
- https://ark-ui.com/llms.txt

Read [PUBLISHING.md](./PUBLISHING.md) before editing release or registry wiring.
