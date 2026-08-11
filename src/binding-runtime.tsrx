import { mergeProps } from '@zag-js/core';
import {
	Context,
	createRefKey,
	effect,
	track,
	type Children,
	type DynamicElementType,
	type RefKey,
	type Tracked,
} from 'ripple';
// components.ts does not import this module, so pulling usePresence in here
// stays acyclic — see presence.tsrx for the standalone Presence.Root sibling.
import { usePresence } from './components';

type AnyRecord = Record<string, any>;
let partIdCount = 0;
type ChildrenProps = { children?: Children | Children[] };
export type ComponentProps = ChildrenProps;

export function createPartId(prefix: string): string {
	// Ark's group parts require an id even when the caller omits one. Ripple has
	// no hydration-stable useId yet, so this shares the root auto-id limitation
	// tracked in .agents/backlog.md instead of leaving group semantics broken.
	return `${prefix}-${++partIdCount}`;
}

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

// Base UI's function-form composition (https://base-ui.com/react/handbook/composition;
// decision recorded in README.md "Composition"), function form only — no
// asChild child-cloning, no `as` prop, no element-form `render={<X />}`. One alias shared
// by every generated part/tagged-Root type instead of repeating the signature per part.
// Omits the origin tag's own `ref` field and its `RefKey` symbol counterpart
// (deviation from the spec's literal `JSX.IntrinsicElements[T] & Record<string, any>`):
// the verified ref contract (see Part below) never puts the composed ref on the
// string `ref` key — presence parts omit it and
// ride a createRefKey() symbol instead, non-presence parts pass through an
// element-agnostic callback — so typing `ref`/`[RefKey]` as the origin tag's own
// `RefValue<HTMLDivElement>` etc. is a lie that breaks the feature's entire point
// (swapping to a different tag, e.g. div Trigger -> <a>) under strict mode's
// ref-type checking.
export type RenderProp<T extends ElementType> =
	(props: Omit<JSX.IntrinsicElements[T], 'ref' | RefKey> & Record<string, any>) => Children;

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
	propDefaults?: Record<string, () => unknown>;
	// Presence-only: `ref` must be pulled out of localProps so the part's own
	// composed ref (setNode + user ref) is the sole ref reaching the element.
	omitKeys?: readonly string[];
	inheritedProps?: | Context<Tracked<AnyRecord> | null>
	| readonly Context<Tracked<AnyRecord> | null>[];
	provideProps?: Context<Tracked<AnyRecord> | null>;
	// Presence layer: merged between the machine getter and localProps, mirroring
	// upstream's mergeProps(getter, presenceLayer, localProps) order (e.g.
	// Content's hidden/data-state, Trigger's aria-controls-only coupling).
	presence?: PresenceSource;
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
		// `render` (Base UI-style function-form composition, see createRenderContent
		// below) is consumed by the part's own render-branch check, never a machine
		// config prop or a DOM attribute — drop it here alongside `children` so every
		// splitProps call site, including hand-rolled overrides that call it directly,
		// excludes it for free instead of each needing its own omit entry.
		if (key === 'children' || key === 'render') continue;
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

export type RenderStrategyProps = {
	lazyMount?: boolean;
	unmountOnExit?: boolean;
};

export type PresenceSource = Context<Tracked<PresenceState> | null> | Tracked<PresenceState>;

const renderStrategyContext = /*#__PURE__*/ new Context<Tracked<RenderStrategyProps> | null>(null);

export const RENDER_STRATEGY_KEYS = ['lazyMount', 'unmountOnExit'] as const;

export function provideRenderStrategy(props: RenderStrategyProps): void {
	renderStrategyContext.set(
		track(
			() => ({
				lazyMount: props.lazyMount,
				unmountOnExit: props.unmountOnExit,
			}),
		),
	);
}

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
 * The caller supplies the desired present source because upstream's merge order
 * differs by Root; generated bindings preserve that order per component.
 */
function createPresenceState(
	present: () => boolean,
	strategy: () => RenderStrategyProps,
	props: { immediate?: boolean; onExitComplete?: () => void; skipAnimationOnMount?: boolean },
) {
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
			unmounted: !machine.value.present && !wasEverPresent.value && Boolean(strategy().lazyMount) ||
				Boolean(strategy().unmountOnExit) && !machine.value.present && wasEverPresent.value,
			presenceProps: {
				hidden: !machine.value.present,
				// The desired state must flip before Zag's lingering `present` does so exit
				// animations can select their closed-state styles while remaining mounted.
				'data-state': machine.value.skip && (props as AnyRecord).skipAnimationOnMount
					? undefined
					: present()
						? 'open'
						: 'closed',
			},
			setNode: machine.value.setNode,
		}),
	);
	return state;
}

export function useRootPresence(
	presenceContext: Context<Tracked<PresenceState> | null>,
	present: () => boolean,
	props: ChildrenProps,
): void {
	const state = createPresenceState(
		present,
		() => props as RenderStrategyProps,
		props as AnyRecord,
	);
	presenceContext.set(state);
}

export function usePartPresence(
	present: () => boolean,
	options: { immediate?: boolean } = {},
): Tracked<PresenceState> {
	const strategy = renderStrategyContext.get();
	return createPresenceState(present, () => strategy?.value ?? {}, options);
}

function resolvePresence(source: PresenceSource | undefined) {
	if (!source) return null;
	return source instanceof Context ? usePresenceState(source) : source;
}

export function usePartProps<TApi extends object>(
	options: PartOptions<TApi>,
	props: ChildrenProps,
) {
	const api = useBindingContext(options.context);
	const presenceState = resolvePresence(options.presence);
	const machineProps = track(() => {
		const [ownProps] = splitProps(props, options.propKeys ?? []);
		const inheritedContexts =
			Array.isArray(options.inheritedProps)
				? options.inheritedProps
				: options.inheritedProps
					? [options.inheritedProps]
					: [];
		const merged = Object.assign(
			{},
			...inheritedContexts.map((inherited) => inherited.get()?.value ?? {}),
			ownProps,
		);
		for (const [key, fallback] of Object.entries(options.propDefaults ?? {})) {
			if ((ownProps as AnyRecord)[key] === undefined) merged[key] = fallback();
		}
		return merged;
	});
	options.provideProps?.set(machineProps);
	return track(() => {
		const getter = options.getter ? (api.value as AnyRecord)[options.getter] : undefined;
		const [, localProps] = splitProps(props, options.propKeys ?? [], options.omitKeys);
		const presenceLayer =
			presenceState
				? (options.presenceProps
					? options.presenceProps(presenceState.value)
					: presenceState.value.presenceProps)
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
		// `render` is excluded the same way `children` is — see splitProps. Cast for the
		// same reason as the rest of this file's `(props as AnyRecord).xxx` reads: `render`
		// is part of a generated part's own honest prop type, not this generic ChildrenProps.
		const { children: _children, render: _render, ...localProps } = props as
			ChildrenProps & {
				render?: unknown;
			};
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

// The generated part templates' `render` branch (`@if (props.render) { ... }`):
// reuses createReactiveObject so property reads inside the consumer's spread stay
// subscribed to the live merged props across the single render() call, the same
// contract createApiContext/createItemContext already give their render props.
// Returning the Content function itself (not just the live props) keeps every
// template call site to one line: `const Content = createRenderContent(mergedProps,
// props.render);` followed by `<{Content} />`.
export function createRenderContent<TProps extends object>(
	props: Tracked<TProps>,
	render: (props: TProps) => Children,
) {
	const liveProps = createReactiveObject(props);
	return () => render(liveProps);
}

export type PartFrameProps = {
	tag: DynamicElementType;
	// The part's consumer-facing props: the source of `render`, `ref`, and (for
	// the options form) everything usePartProps splits.
	of: AnyRecord;
	options?: PartOptions<AnyRecord>;
	merged?: Tracked<AnyRecord>;
	// Rare explicit element attributes that upstream applies after its merged
	// spread (for example Tour.Backdrop's step-controlled `hidden`).
	finalProps?: () => AnyRecord;
	// Presence context for gate/composeRef — distinct from options.presence,
	// which is the presenceProps *merge* channel: a part can gate without merging
	// (Positioner) and merge without gating (aria-controls triggers); see
	// presencePartBehaviors in generate-bindings.ts.
	presence?: PresenceSource;
	gate?: boolean;
	composeRef?: boolean;
	children?: Children | Children[];
};

/**
 * The one element frame every generated part and tagged Root/RootProvider
 * renders through: resolves merged props (usePartProps unless the caller
 * precomputed them), applies the presence gate and composed ref, and branches
 * Base UI's function-form render. Exists so ~200 generated call sites stay one
 * declarative line each instead of repeating this machinery.
 *
 * The void-tag contract rides on `children`: a self-closed `<Part />` receives
 * no children block at all, so `children === undefined` selects the childless
 * element form — the generator only self-closes for void tags.
 */
export function Part(props: PartFrameProps) @{
	let &{ tag, of, gate, composeRef, children } = props;
	const presence = resolvePresence(props.presence);
	const mergedProps = props.merged ?? usePartProps(props.options!, of);
	const elementProps =
		props.finalProps
			? track(() => mergeProps(mergedProps.value, props.finalProps!()))
			: mergedProps;
	// Ref contract (verified against ripple's render.js + tsrx-ripple's "spreading
	// into composite refs" test): a plain string `ref` key in a spread object gets
	// NO special treatment, but apply_element_spread applies whatever function sits
	// under a createRefKey() symbol — and that survives being re-spread through a
	// consumer's rest-props forwarding, so a render consumer needs no special
	// handling. Key and callback are composed once at setup: ripple caches ref
	// effects by symbol+function identity, so recreating either per update would
	// tear down and re-create the DOM ref binding on every reactive props change.
	const presenceRefKey = createRefKey();
	// `let` (not const): the compiler lowers a bare-identifier ref={x} attribute
	// with an unconditional write-back setter, so the target must stay assignable
	// even though ripple never fires that setter for a function value. `node: any`
	// because this one callback must satisfy both setNode(HTMLElement | null) and
	// whatever narrower element type each part's own `ref` prop declares. ripple
	// only runs a *returned* function as ref cleanup and never re-invokes with
	// `null` — not returning one preserves pre-Part behavior (see backlog:
	// "Presence composed ref doesn't forward a user ref's cleanup").
	let applyRef = (node: any) => {
		presence?.value.setNode(node);
		const userRef = of.ref;
		if (typeof userRef === 'function') userRef(node);
	};
	@if (!gate || !presence!.value.unmounted) {
		@if (of.render) {
			const Content = createRenderContent(
				composeRef
					? track(() => ({ ...elementProps.value, [presenceRefKey]: applyRef }))
					: elementProps,
				of.render,
			);
			<{Content} />
		} @else if (composeRef) {
			<{tag} {...elementProps.value} ref={applyRef}>{children}</{tag}>
		} @else if (children === undefined) {
			<{tag} {...elementProps.value} />
		} @else {
			<{tag} {...elementProps.value}>{children}</{tag}>
		}
	}
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
	getter: string | ((props: AnyRecord) => string) = 'getItemState',
) {
	return function ItemContext(props: { render: (state: AnyRecord) => Children }) @{
		let &{ render } = props;
		const api = useBindingContext(context);
		const itemProps = propsContext.get();
		if (!itemProps) throw new Error('ItemContext must be rendered inside its Item');
		const state = track(
			() => api.value[typeof getter === 'function' ? getter(itemProps.value) : getter](
				itemProps.value,
			),
		);
		const liveState = createReactiveObject(state);
		const Content = () => render(liveState);
		<{Content} />
	};
}
