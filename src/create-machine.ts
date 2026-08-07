import type { Machine, MachineSchema, Service } from "@zag-js/core";
import { normalizeProps, useMachine } from "@celados/ripple-zag";
import { track, type Tracked } from "ripple";

export type MaybeTracked<T> = {
  [K in keyof T]?: T[K] | Tracked<Exclude<T[K], undefined>>;
};

type Connect<TSchema extends MachineSchema, TApi> = (
  service: Service<TSchema>,
  normalize: typeof normalizeProps,
) => TApi;

export type MachineHookResult<
  TSchema extends MachineSchema,
  TApi,
> = Tracked<TApi> & {
  readonly service: Service<TSchema>;
};

export type MachineHook<TProps, TApi, TService> = (
  props?: MaybeTracked<TProps>,
) => Tracked<TApi> & { readonly service: TService };

export type MachineProps<TMachine> =
  TMachine extends Machine<infer TSchema> ? TSchema["props"] : never;

/**
 * Creates the Ripple-facing hook for one Zag machine.
 *
 * The connected API stays tracked because its event handlers and data attributes
 * are derived from machine state; returning a snapshot would silently go stale.
 */
export function createMachineHook<TSchema extends MachineSchema, TApi>(
  machine: Machine<TSchema>,
  connect: Connect<TSchema, TApi>,
) {
  return (
    props: MaybeTracked<TSchema["props"]> = {},
  ): MachineHookResult<TSchema, TApi> => {
    const service = useMachine(machine, props);
    const api = track(() => connect(service, normalizeProps));

    // Nested machines need the underlying service to establish parent/child
    // relationships; keeping it on the tracked API avoids leaking machine setup.
    return Object.assign(api, { service });
  };
}
