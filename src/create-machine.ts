import type { Machine, MachineSchema, Service } from '@zag-js/core';
import { normalizeProps, useMachine } from '@celados/ripple-zag';
import { track, type Tracked } from 'ripple';

import { useEnvironmentContext } from './providers/environment.tsrx';
import { useLocaleContext } from './providers/locale.tsrx';

export type MaybeTracked<T> = {
	[K in keyof T]?: T[K] | Tracked<Exclude<T[K], undefined>>;
};

type Connect<TSchema extends MachineSchema, TApi> = (
	service: Service<TSchema>,
	normalize: typeof normalizeProps
) => TApi;

export type MachineHookResult<TSchema extends MachineSchema, TApi> = Tracked<TApi> & {
	readonly service: Service<TSchema>;
};

export type MachineHook<TProps, TApi, TService> = (
	props?: MaybeTracked<TProps>
) => Tracked<TApi> & { readonly service: TService };

export type MachineProps<TMachine> =
	TMachine extends Machine<infer TSchema> ? TSchema['props'] : never;

type AnyRecord = Record<string, any>;

let instanceCount = 0;

/**
 * Lays default machine props under user props without spreading: generated
 * Roots pass objects whose keys are live getters, and a spread would freeze
 * them into a single snapshot.
 */
function withDefaults(props: AnyRecord, defaults: Record<string, () => unknown>) {
	const merged: AnyRecord = {};
	for (const key of new Set([...Object.keys(defaults), ...Object.keys(props)])) {
		const fallback = defaults[key];
		Object.defineProperty(merged, key, {
			enumerable: true,
			// An explicit `undefined` (e.g. { id: undefined }) must still fall
			// back, or zag throws its missing-required-props error.
			get: fallback ? () => props[key] ?? fallback() : () => props[key],
		});
	}
	return merged;
}

/**
 * Creates the Ripple-facing hook for one Zag machine.
 *
 * The connected API stays tracked because its event handlers and data attributes
 * are derived from machine state; returning a snapshot would silently go stale.
 */
export function createMachineHook<TSchema extends MachineSchema, TApi>(
	machine: Machine<TSchema>,
	connect: Connect<TSchema, TApi>
) {
	return (props: MaybeTracked<TSchema['props']> = {}): MachineHookResult<TSchema, TApi> => {
		// Ark's Solid hooks inject these per instance: zag machines require an
		// id, and read dir/getRootNode for RTL and shadow-DOM support. Context
		// reads keep hooks component-setup-only, which was already the contract.
		const locale = useLocaleContext();
		const environment = useEnvironmentContext();
		// Setup runs once per instance, so a monotonic counter is stable for the
		// instance lifetime. SSR/hydration id stability is not addressed here.
		const autoId = `ark-${++instanceCount}`;
		const machineProps = withDefaults(props, {
			id: () => autoId,
			dir: () => locale.value.dir,
			getRootNode: () => environment.value.getRootNode,
		}) as MaybeTracked<TSchema['props']>;
		const service = useMachine(machine, machineProps);
		const api = track(() => connect(service, normalizeProps));

		// Nested machines need the underlying service to establish parent/child
		// relationships; keeping it on the tracked API avoids leaking machine setup.
		return Object.assign(api, { service });
	};
}
