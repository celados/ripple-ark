import { mergeProps } from '@zag-js/core';
import { Context, track, type Children, type DynamicElementType, type Tracked } from 'ripple';

type AnyRecord = Record<string, any>;

export type ArkPartProps =
	AnyRecord & {
		as?: DynamicElementType;
		children?: Children | Children[];
	};

type BindingContext = Context<Tracked<AnyRecord> | null>;

type RootOptions = {
	context: BindingContext;
	defaultTag?: DynamicElementType;
	defaultMachineProps?: () => AnyRecord;
	configKeys: readonly string[];
	useMachine: (props: AnyRecord) => Tracked<AnyRecord>;
};

type PartOptions = {
	context: BindingContext;
	defaultTag: DynamicElementType;
	getter?: string;
	propKeys?: readonly string[];
	inheritedProps?: Context<AnyRecord | null>;
	provideProps?: Context<AnyRecord | null>;
};

function splitProps(props: ArkPartProps, keys: readonly string[]) {
	const selected: AnyRecord = {};
	const local: AnyRecord = {};
	for (const [key, value] of Object.entries(props)) {
		if (key === 'as' || key === 'children') continue;
		if (keys.includes(key)) selected[key] = value;
		else local[key] = value;
	}
	return [selected, local] as const;
}

function useBindingContext(context: BindingContext) {
	const api = context.get();
	if (!api) throw new Error('Ark part must be rendered inside its Root or RootProvider');
	return api;
}

export function createRoot(options: RootOptions) {
	return function Root(props: ArkPartProps) @{
		const { as = options.defaultTag, children } = props;
		const [machineProps, localProps] = splitProps(props, options.configKeys);
		const api = options.useMachine({ ...options.defaultMachineProps?.(), ...machineProps });
		options.context.set(api);
		// Zag's merge composes handlers, refs, class names, and styles. Object spread
		// would silently replace machine behavior when consumers add their own props.
		const mergedProps = track(() => mergeProps(api.value.getRootProps?.(), localProps));

		<>
			@if (as) {
				<{as} {...mergedProps.value}>{children}</{as}>
			} @else {
				{
					children;
				}
			}
		</>
	};
}

export function createRootProvider(options: Omit<RootOptions, 'configKeys' | 'useMachine'>) {
	return function RootProvider(props: ArkPartProps & { value: Tracked<AnyRecord> }) @{
		const { as = options.defaultTag, children, value, ...localProps } = props;
		options.context.set(value);
		const mergedProps = track(() => mergeProps(value.value.getRootProps?.(), localProps));

		<>
			@if (as) {
				<{as} {...mergedProps.value}>{children}</{as}>
			} @else {
				{
					children;
				}
			}
		</>
	};
}

export function createPart(options: PartOptions) {
	return function Part(props: ArkPartProps) @{
		const { as = options.defaultTag, children } = props;
		const api = useBindingContext(options.context);
		const [ownProps, localProps] = splitProps(props, options.propKeys ?? []);
		const machineProps = { ...(options.inheritedProps?.get() ?? {}), ...ownProps };
		options.provideProps?.set(machineProps);
		const mergedProps = track(
			() => mergeProps(options.getter ? api.value[options.getter](machineProps) : {}, localProps),
		);

		<{as} {...mergedProps.value}>{children}</{as}>
	};
}

export function createExternalPart(options: Pick<PartOptions, 'defaultTag' | 'getter'> & {
	context: BindingContext;
}) {
	return function ExternalPart(props: ArkPartProps) @{
		const { as = options.defaultTag, children, ...localProps } = props;
		const api = useBindingContext(options.context);
		const mergedProps = track(
			() => mergeProps(options.getter ? api.value[options.getter]() : {}, localProps),
		);
		<{as} {...mergedProps.value}>{children}</{as}>
	};
}

export function createApiContext(context: BindingContext) {
	return function ApiContext(props: { children: (api: AnyRecord) => Children }) @{
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
