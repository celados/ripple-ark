import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTabs } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useTabs;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'activationMode',
				'composite',
				'defaultValue',
				'deselectable',
				'id',
				'ids',
				'loopFocus',
				'navigate',
				'onFocusChange',
				'onValueChange',
				'orientation',
				'translations',
				'value',
			],

			useMachine: useTabs as any,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getContentProps',
			propKeys: [
				'value',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'disabled',
				'value',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Indicator(props: IndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function List(props: ListProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getListProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;
export type ListProps = PartProps<'div', Api['getListProps']>;

export const Tabs = { Root, RootProvider, Content, Trigger, Indicator, List, Context };
