import { mergeProps } from '@zag-js/core';
import { Context, effect, track, type Children, type Tracked } from 'ripple';
// components.ts does not import this module, so pulling usePresence in here
// stays acyclic — see presence.tsrx for the standalone Presence.Root sibling.
import { usePresence } from './components';

type AnyRecord = Record<string, any>;
type ChildrenProps = { children?: Children | Children[] };
export type ComponentProps = ChildrenProps;

type ElementType = keyof JSX.IntrinsicElements;
type RemoveIndexSignature<T> =
	{ [K in keyof T as string extends K ? never : number extends K ? never : K]: T[K] };
type OpenAttributes = { [name: string]: any };
type NativePartProps<T extends ElementType> =
	RemoveIndexSignature<JSX.IntrinsicElements[T]> & {
		children?: Children | Children[];
	};
export type ArkPartProps<T extends ElementType = 'div'> = NativePartProps<T> & OpenAttributes;
export type GetterProps<T> =
	T extends (...args: infer TArgs) => unknown
		? TArgs extends [infer TFirst, ...unknown[]] ? NonNullable<TFirst> : Record<never, never>
		: Record<never, never>;
export type PartProps<T extends ElementType, TGetter = never> =
	Omit<NativePartProps<T>, keyof GetterProps<TGetter>> & GetterProps<TGetter> & OpenAttributes;

type BindingContext<TApi extends object = AnyRecord> = Context<Tracked<TApi> | null>;

type RootOptions<TApi extends object> = {
	context: BindingContext<TApi>;
	defaultMachineProps?: () => AnyRecord;
	configKeys: readonly string[];
	// Keys reserved by a layer above the machine (presence render-strategy props)
	// that must not leak onto the DOM element but also aren't machine config.
	omitKeys?: readonly string[];
	// Per-key reactive fallback for configKeys the caller didn't pass — e.g.
	// Checkbox.Root layering Checkbox.Group's derived checked/onCheckedChange
	// under whatever the individual checkbox explicitly sets. Unlike
	// defaultMachineProps (one static snapshot), each getter re-reads live so
	// group state keeps flowing after mount.
	machineDefaults?: Record<string, () => unknown>;
	useMachine: (props: AnyRecord) => Tracked<TApi>;
};

export type PartOptions<TApi extends object> = {
	context: BindingContext<TApi>;
	getter?: Extract<keyof TApi, string>;
	propKeys?: readonly string[];
	// Presence-only: `ref` must be pulled out of localProps so the part's own
	// composed ref (setNode + user ref) is the sole ref reaching the element.
	omitKeys?: readonly string[];
	inheritedProps?: | Context<Tracked<AnyRecord> | null>
	| readonly Context<Tracked<AnyRecord> | null>[];
	provideProps?: Context<Tracked<AnyRecord> | null>;
	// Presence layer: merged between the machine getter and localProps, mirroring
	// upstream's mergeProps(getter, presenceLayer, localProps) order (e.g.
	// Content's hidden/data-state, Trigger's aria-controls-only coupling).
	presence?: Context<Tracked<PresenceState> | null>;
	presenceProps?: (state: PresenceState) => AnyRecord;
};

// Exported for the rare bespoke override (e.g. Checkbox.Group) that renders its
// own element outside usePartProps/useRootProps but still needs the same
// children-excluding, key-partitioning split those helpers use internally.
export function splitProps(
	props: ChildrenProps,
	keys: readonly string[],
	omit: readonly string[] = [],
) {
	const selected: AnyRecord = {};
	const local: AnyRecord = {};
	for (const [key, value] of Object.entries(props)) {
		if (key === 'children') continue;
		if (keys.includes(key)) selected[key] = value;
		else if (!omit.includes(key)) local[key] = value;
	}
	return [selected, local] as const;
}

function createReactiveProps(
	props: ChildrenProps,
	keys: readonly string[],
	defaults: AnyRecord = {},
	reactiveDefaults?: Record<string, () => unknown>,
) {
	const reactiveProps: AnyRecord = { ...defaults };
	for (const key of keys) {
		const reactiveDefault = reactiveDefaults?.[key];
		if (!(key in props) && !reactiveDefault) continue;
		Object.defineProperty(reactiveProps, key, {
			enumerable: true,
			get: () => (key in props ? (props as AnyRecord)[key] : reactiveDefault!()),
		});
	}
	return reactiveProps;
}

function useBindingContext<TApi extends object>(context: BindingContext<TApi>) {
	const api = context.get();
	if (!api) throw new Error('Ark part must be rendered inside its Root or RootProvider');
	return api;
}

export function usePresenceState(context: Context<Tracked<PresenceState> | null>) {
	const state = context.get();
	if (!state) throw new Error('Ark part must be rendered inside its Root or RootProvider');
	return state;
}

export function useRootProps<TApi extends object>(
	options: RootOptions<TApi>,
	props: ChildrenProps,
) {
	const machineProps = createReactiveProps(
		props,
		options.configKeys,
		options.defaultMachineProps?.(),
		options.machineDefaults,
	);
	const api = options.useMachine(machineProps);
	options.context.set(api);
	// Zag's merge composes handlers, refs, class names, and styles. Object spread
	// would silently replace machine behavior when consumers add their own props.
	return track(() => {
		const [, localProps] = splitProps(props, options.configKeys, options.omitKeys);
		return mergeProps((api.value as AnyRecord).getRootProps?.(), localProps);
	});
}

export function useRootProviderProps<TApi extends object>(
	options: Pick<RootOptions<TApi>, 'context' | 'omitKeys'>,
	props: ChildrenProps & { value: Tracked<TApi> },
) {
	const value = track(() => props.value.value);
	options.context.set(value);
	return track(() => {
		// `value` is consumed above; folding it into the omit list keeps DOM-leakage
		// rules identical to useRootProps instead of a second ad hoc destructure.
		const [, localProps] = splitProps(props, [], ['value', ...(options.omitKeys ?? [])]);
		return mergeProps((value.value as AnyRecord).getRootProps?.(), localProps);
	});
}

export type PresenceState = {
	unmounted: boolean;
	presenceProps: AnyRecord;
	setNode(node: HTMLElement | null): void;
};

// Mirrors upstream presence/split-presence-props.ts + utils/render-strategy.ts:
// the full prop surface Ark's Presence layer reserves on a tagged Root before
// any localProps reach the DOM. `present` and `unmountOnExit`/`lazyMount` are
// read directly off `props` below rather than folded into machineProps, since
// only `present`/`immediate`/`onExitComplete` are @zag-js/presence's own props.
export const PRESENCE_KEYS = [
	'immediate',
	'lazyMount',
	'onExitComplete',
	'present',
	'skipAnimationOnMount',
	'unmountOnExit',
] as const;

/**
 * Builds the Zag presence machine for a Root/RootProvider and publishes its
 * derived state on `presenceContext`, mirroring presence.tsrx's PresenceRoot
 * (unmounted = lazyMount/unmountOnExit gating; presenceProps = hidden + data-state).
 * `present` always comes from machine state (open), never a user `present` prop —
 * upstream's mergeProps order lets machine state win in 10 of 12 roots; the other
 * two (select, floating-panel) invert the order, which reads as an upstream
 * inconsistency rather than intent, so this keeps the behavior uniform.
 */
export function useRootPresence(
	presenceContext: Context<Tracked<PresenceState> | null>,
	present: () => boolean,
	props: ChildrenProps,
): void {
	const machine = usePresence({
		get present() {
			return present();
		},
		get immediate() {
			return (props as AnyRecord).immediate;
		},
		get onExitComplete() {
			return (props as AnyRecord).onExitComplete;
		},
	});
	const wasEverPresent = track(false);
	effect(() => {
		if (machine.value.present) wasEverPresent.value = true;
	});
	const state = track(
		() => ({
			unmounted: !machine.value.present && !wasEverPresent.value &&
				Boolean((props as AnyRecord).lazyMount) ||
				Boolean((props as AnyRecord).unmountOnExit) && !machine.value.present &&
					wasEverPresent.value,
			presenceProps: {
				hidden: !machine.value.present,
				'data-state': machine.value.skip && (props as AnyRecord).skipAnimationOnMount
					? undefined
					: machine.value.present
						? 'open'
						: 'closed',
			},
			setNode: machine.value.setNode,
		}),
	);
	presenceContext.set(state);
}

export function usePartProps<TApi extends object>(
	options: PartOptions<TApi>,
	props: ChildrenProps,
) {
	const api = useBindingContext(options.context);
	const machineProps = track(() => {
		const [ownProps] = splitProps(props, options.propKeys ?? []);
		const inheritedContexts =
			Array.isArray(options.inheritedProps)
				? options.inheritedProps
				: options.inheritedProps
					? [options.inheritedProps]
					: [];
		return Object.assign(
			{},
			...inheritedContexts.map((inherited) => inherited.get()?.value ?? {}),
			ownProps,
		);
	});
	options.provideProps?.set(machineProps);
	return track(() => {
		const getter = options.getter ? (api.value as AnyRecord)[options.getter] : undefined;
		const [, localProps] = splitProps(props, options.propKeys ?? [], options.omitKeys);
		const presenceState = options.presence?.get()?.value;
		const presenceLayer =
			presenceState
				? (options.presenceProps
					? options.presenceProps(presenceState)
					: presenceState.presenceProps)
				: undefined;
		return mergeProps(
			typeof getter === 'function' ? getter(machineProps.value) : {},
			presenceLayer,
			localProps,
		);
	});
}

export function useExternalPartProps<TApi extends object>(
	options: Pick<PartOptions<TApi>, 'context' | 'getter'>,
	props: ChildrenProps,
) {
	const api = useBindingContext(options.context);
	return track(() => {
		// This snapshot is rebuilt inside the tracked computation, so it stays reactive.
		const { children: _children, ...localProps } = props;
		return mergeProps(options.getter ? (api.value as AnyRecord)[options.getter]() : {}, localProps);
	});
}

function createReactiveObject<TValue extends object>(value: Tracked<TValue>): TValue {
	// Render callbacks execute once, so expose a stable object whose reads still
	// subscribe to the current Zag connection instead of capturing one snapshot.
	return new Proxy({} as TValue, {
		get: (_target, key) => Reflect.get(value.value, key),
		has: (_target, key) => Reflect.has(value.value, key),
		ownKeys: () => Reflect.ownKeys(value.value),
		getOwnPropertyDescriptor: (_target, key) =>
			Reflect.getOwnPropertyDescriptor(value.value, key) ??
				{
					configurable: true,
					enumerable: true,
				},
	});
}

export function createApiContext<TApi extends object>(context: BindingContext<TApi>) {
	return function ApiContext(props: { render: (api: TApi) => Children }) @{
		const api = useBindingContext(context);
		const liveApi = createReactiveObject(api);
		const Content = () => props.render(liveApi);
		<{Content} />
	};
}

export function createItemContext(
	context: BindingContext,
	propsContext: Context<Tracked<AnyRecord> | null>,
	getter = 'getItemState',
) {
	return function ItemContext(props: { render: (state: AnyRecord) => Children }) @{
		let &{ render } = props;
		const api = useBindingContext(context);
		const itemProps = propsContext.get();
		if (!itemProps) throw new Error('ItemContext must be rendered inside its Item');
		const state = track(() => api.value[getter](itemProps.value));
		const liveState = createReactiveObject(state);
		const Content = () => render(liveState);
		<{Content} />
	};
}
