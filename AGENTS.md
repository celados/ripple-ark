# ripple-ark

This repository is the Ark UI adapter for Ripple. It owns compound TSRX components,
machine startup, Ripple tracking, prop normalization, framework providers, and demos.
Styles remain consumer-owned.

## Commands

Use Bun: `bun install`, `bun run typecheck`, `bun run test`, and `bun run build`.
Every release must pass a clean-consumer compile against the packed artifact.

## Boundaries

- Keep every public Ark UI component directory represented by a Ripple subpath.
- Preserve Ark's namespace vocabulary (`Root`, `Trigger`, `Content`, contexts, and
  providers) while implementing it with Ripple primitives rather than another framework runtime.
- Keep one lower-level `useXxx` hook for every current Zag component machine.
- Hooks return a tracked connected API. The attached `service` exists for nested
  parent/child machines; ordinary consumers should use `api.value`.
- Static TSRX text is native JSX text. Use expressions for dynamic values and for
  parser-required escapes such as whitespace-only nodes.
- Regenerate bindings only against a fresh `chakra-ui/ark` snapshot, then run the
  namespace parity, all-subpath compile, and SSR gates before accepting the result.
- Comments explain the adapter constraint or trade-off, not the code operation.

## Current sources

Read these before changing integration behavior:

- https://www.ripple-ts.com/llms.txt
- https://zagjs.com/llms.txt
- https://ark-ui.com/llms.txt

Read [PUBLISHING.md](./PUBLISHING.md) before editing release or registry wiring.
