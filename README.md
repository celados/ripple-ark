# ripple-ark

Ark UI bindings for Ripple. The package maps Ark's compound component API to TSRX while keeping Zag
machines reactive through Ripple `Tracked` values.

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

Use component subpaths such as `@celados/ripple-ark/dialog`. The root export also includes the
lower-level `useXxx` hooks for advanced composition, providers, the `ark` factory, and collection
helpers. Demos live in `@celados/ripple-ark/demos`; they are dogfooded by ripple-explore.

This is a Ripple source package. Consumers must compile `.tsrx` through the Ripple TypeScript/Vite
toolchain; no Solid, React, Vue, or Svelte runtime is included.
