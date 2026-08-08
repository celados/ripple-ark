import { mergeProps } from '@zag-js/core';
import { Context, track, type Children, type Tracked } from 'ripple';

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
	useMachine: (props: AnyRecord) => Tracked<TApi>;
};

export type PartOptions<TApi extends object> = {
	context: BindingContext<TApi>;
	getter?: Extract<keyof TApi, string>;
	propKeys?: readonly string[];
	inheritedProps?: Context<Tracked<AnyRecord> | null>;
	provideProps?: Context<Tracked<AnyRecord> | null>;
};

function splitProps(props: ChildrenProps, keys: readonly string[]) {
	const selected: AnyRecord = {};
	const local: AnyRecord = {};
	for (const [key, value] of Object.entries(props)) {
		if (key === 'children') continue;
		if (keys.includes(key)) selected[key] = value;
		else local[key] = value;
	}
	return [selected, local] as const;
}

function createReactiveProps(
	props: ChildrenProps,
	keys: readonly string[],
	defaults: AnyRecord = {},
) {
	const reactiveProps: AnyRecord = { ...defaults };
	for (const key of keys) {
		if (!(key in props)) continue;
		Object.defineProperty(reactiveProps, key, {
			enumerable: true,
			get: () => (props as AnyRecord)[key],
		});
	}
	return reactiveProps;
}

function useBindingContext<TApi extends object>(context: BindingContext<TApi>) {
	const api = context.get();
	if (!api) throw new Error('Ark part must be rendered inside its Root or RootProvider');
	return api;
}

export function useRootProps<TApi extends object>(
	options: RootOptions<TApi>,
	props: ChildrenProps,
) {
	const machineProps = createReactiveProps(
		props,
		options.configKeys,
		options.defaultMachineProps?.(),
	);
	const api = options.useMachine(machineProps);
	options.context.set(api);
	// Zag's merge composes handlers, refs, class names, and styles. Object spread
	// would silently replace machine behavior when consumers add their own props.
	return track(() => {
		const [, localProps] = splitProps(props, options.configKeys);
		return mergeProps((api.value as AnyRecord).getRootProps?.(), localProps);
	});
}

export function useRootProviderProps<TApi extends object>(
	options: Pick<RootOptions<TApi>, 'context'>,
	props: ChildrenProps & { value: Tracked<TApi> },
) {
	const value = track(() => props.value.value);
	options.context.set(value);
	return track(() => {
		// This snapshot is rebuilt inside the tracked computation, so it stays reactive.
		const { children: _children, value: _value, ...localProps } = props;
		return mergeProps((value.value as AnyRecord).getRootProps?.(), localProps);
	});
}

export function usePartProps<TApi extends object>(
	options: PartOptions<TApi>,
	props: ChildrenProps,
) {
	const api = useBindingContext(options.context);
	const machineProps = track(() => {
		const [ownProps] = splitProps(props, options.propKeys ?? []);
		return { ...(options.inheritedProps?.get()?.value ?? {}), ...ownProps };
	});
	options.provideProps?.set(machineProps);
	return track(() => {
		const getter = options.getter ? (api.value as AnyRecord)[options.getter] : undefined;
		const [, localProps] = splitProps(props, options.propKeys ?? []);
		return mergeProps(typeof getter === 'function' ? getter(machineProps.value) : {}, localProps);
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

export function createApiContext<TApi extends object>(context: BindingContext<TApi>) {
	return function ApiContext(props: { render: (api: TApi) => Children }) @{
		const api = useBindingContext(context);
		const Content = () => props.render(api.value);
		<{Content} />
	};
}

export function createItemContext(
	context: BindingContext,
	propsContext: Context<Tracked<AnyRecord> | null>,
	getter = 'getItemState',
) {
	return function ItemContext(props: { render: (state: AnyRecord) => Children }) @{
		const api = useBindingContext(context);
		const itemProps = propsContext.get();
		if (!itemProps) throw new Error('ItemContext must be rendered inside its Item');
		const state = track(() => api.value[getter](itemProps.value));
		const Content = () => props.render(state.value);
		<{Content} />
	};
}
