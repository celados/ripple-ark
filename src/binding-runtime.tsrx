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
	inheritedProps?: Context<AnyRecord | null>;
	provideProps?: Context<AnyRecord | null>;
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

function useBindingContext<TApi extends object>(context: BindingContext<TApi>) {
	const api = context.get();
	if (!api) throw new Error('Ark part must be rendered inside its Root or RootProvider');
	return api;
}

export function useRootProps<TApi extends object>(
	options: RootOptions<TApi>,
	props: ChildrenProps,
) {
	const [machineProps, localProps] = splitProps(props, options.configKeys);
	const api = options.useMachine({ ...options.defaultMachineProps?.(), ...machineProps });
	options.context.set(api);
	// Zag's merge composes handlers, refs, class names, and styles. Object spread
	// would silently replace machine behavior when consumers add their own props.
	return track(() => mergeProps((api.value as AnyRecord).getRootProps?.(), localProps));
}

export function useRootProviderProps<TApi extends object>(
	options: Pick<RootOptions<TApi>, 'context'>,
	props: ChildrenProps & { value: Tracked<TApi> },
) {
	const { children: _children, value, ...localProps } = props;
	options.context.set(value);
	return track(() => mergeProps((value.value as AnyRecord).getRootProps?.(), localProps));
}

export function usePartProps<TApi extends object>(
	options: PartOptions<TApi>,
	props: ChildrenProps,
) {
	const api = useBindingContext(options.context);
	const [ownProps, localProps] = splitProps(props, options.propKeys ?? []);
	const machineProps = { ...(options.inheritedProps?.get() ?? {}), ...ownProps };
	options.provideProps?.set(machineProps);
	return track(() => {
		const getter = options.getter ? (api.value as AnyRecord)[options.getter] : undefined;
		return mergeProps(typeof getter === 'function' ? getter(machineProps) : {}, localProps);
	});
}

export function useExternalPartProps<TApi extends object>(
	options: Pick<PartOptions<TApi>, 'context' | 'getter'>,
	props: ChildrenProps,
) {
	const { children: _children, ...localProps } = props;
	const api = useBindingContext(options.context);
	return track(
		() => mergeProps(options.getter ? (api.value as AnyRecord)[options.getter]() : {}, localProps),
	);
}

export function createApiContext<TApi extends object>(context: BindingContext<TApi>) {
	return function ApiContext(props: { children: (api: TApi) => Children }) @{
		const api = useBindingContext(context);
		const render = props.children;
		{
			render(api.value);
		}
	};
}

export function createItemContext(
	context: BindingContext,
	propsContext: Context<AnyRecord | null>,
	getter = 'getItemState',
) {
	return function ItemContext(props: { children: (state: AnyRecord) => Children }) @{
		const api = useBindingContext(context);
		const itemProps = propsContext.get();
		if (!itemProps) throw new Error('ItemContext must be rendered inside its Item');
		const state = track(() => api.value[getter](itemProps));
		const render = props.children;
		{
			render(state.value);
		}
	};
}
