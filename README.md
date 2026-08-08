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
helpers. Ripple Explore owns the documentation examples and consumes these public component
subpaths, so examples cannot bypass the Ark bindings through package-private demo exports.

Generated parts use their native JSX tags directly. Polymorphism is deliberately opt-in through
the `ark` factory instead of adding a dynamic `as` prop to every component.

This is a Ripple source package. Consumers must compile `.tsrx` through the Ripple TypeScript/Vite
toolchain; no Solid, React, Vue, or Svelte runtime is included.
