# ripple-ark

Headless [Ark UI](https://ark-ui.com/) bindings for
[Ripple](https://www.ripple-ts.com/), powered by [Zag](https://zagjs.com/) state machines.

`ripple-ark` keeps Ark's compound-component vocabulary (`Root`, `Trigger`, `Content`, contexts,
and providers), implements it with native TSRX, and exposes connected machine state as reactive
Ripple values. Styles remain entirely consumer-owned.

## Installation

`@celados/ripple-ark` is hosted on the private Celados registry. You need a registry token before
the package and its private dependencies can be installed.

Add a token-free `.npmrc` to the root of the consuming project:

```ini
@celados:registry=https://npm.celados.com
//npm.celados.com/:_authToken=${NODE_AUTH_TOKEN}
```

Set the token in your shell, then install the package and its Ripple peer dependency:

```sh
export NODE_AUTH_TOKEN="<your Celados registry token>"
bun add @celados/ripple-ark ripple
```

Ask the Celados team for registry access if you do not have a token. Never put a token value
directly in a committed `.npmrc`.

In CI, keep the same token-free `.npmrc` and expose the registry credential as
`NODE_AUTH_TOKEN` through the CI secret store.

## Usage

Import each component from its package subpath:

```tsrx
import { Accordion } from '@celados/ripple-ark/accordion';

export function Settings() @{
	<Accordion.Root id="settings" defaultValue={['profile']}>
		<Accordion.Item value="profile">
			<Accordion.ItemTrigger>Profile</Accordion.ItemTrigger>
			<Accordion.ItemContent>Account settings</Accordion.ItemContent>
		</Accordion.Item>
	</Accordion.Root>
}
```

Other component subpaths follow the same pattern:

```tsrx
import { Dialog } from '@celados/ripple-ark/dialog';
import { Select } from '@celados/ripple-ark/select';
import { Tooltip } from '@celados/ripple-ark/tooltip';
```

Component subpaths are the preferred public API. The root export additionally provides:

- lower-level `useXxx` hooks for custom composition
- framework providers
- the `ark` dynamic-tag element factory
- collection and utility helpers

## Composition

Every generated part that renders an element (and every tagged `Root`/`RootProvider`) accepts
a `render` prop, following [Base UI's function-form composition](https://base-ui.com/react/handbook/composition):

```tsrx
<Dialog.Trigger render={(props) => <Link {...props} to="/settings">打开</Link>} />
```

`render` receives the part's merged, normalized props as a live object — reading a property
inside the callback stays subscribed to the underlying machine state — and its return replaces
the default element **entirely**. `children` is ignored once `render` is given.

This is function form only: no Radix/Ark-style `asChild` (child cloning), no `as` prop, and no
element-form `render={<X />}` (a React idiom that doesn't fit Ripple's reactivity model). The
`ark` factory above is unrelated — it is a plain dynamic-tag wrapper, not a composition
mechanism; if you need low-level access without a `render` prop at all, use the part's `Context`
render prop or call a `useXxx` hook directly against the zag getters.

Presence-gated parts (`Dialog.Content`, `Popover.Positioner`, …) compose their internal mount ref
into the same props object under a `createRefKey()`-derived symbol, so it survives a plain
`{...props}` spread or a rest-props forward without the render consumer doing anything special —
spreading the full props object is enough for presence unmount detection to keep working.

## Runtime and build requirements

This is a Ripple source package:

- consumers must compile `.tsrx` with the Ripple TypeScript/Vite toolchain
- `ripple` is a peer dependency and must be present in the consuming application
- no Solid, React, Vue, or Svelte runtime is included
- no component styles are shipped

## License

[MIT](./LICENSE)
