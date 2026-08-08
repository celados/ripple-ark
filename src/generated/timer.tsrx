import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTimer } from '../components';
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

type Hook = typeof useTimer;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'id',
				'ids',
				'autoStart',
				'interval',
				'countdown',
				'startMs',
				'targetMs',
				'translations',
				'onComplete',
				'onTick',
			],

			useMachine: useTimer as any,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'type',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Separator(props: SeparatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSeparatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ActionTrigger(props: ActionTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getActionTriggerProps',
			propKeys: [
				'action',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Area(props: AreaProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getAreaProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type SeparatorProps = PartProps<'div', Api['getSeparatorProps']>;
export type ActionTriggerProps = PartProps<'button', Api['getActionTriggerProps']>;
export type AreaProps = PartProps<'div', Api['getAreaProps']>;

export const Timer = { Root, RootProvider, Control, Item, Separator, ActionTrigger, Area, Context };
