import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTimer } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Item(props: ItemProps) @{
	const api = context.get()!;
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
	<Part
		tag="div"
		merged={mergedProps}
		of={props}
	>{(api.value.formattedTime as any)[(props as any).type]}</Part>
}
export function Separator(props: SeparatorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getSeparatorProps' }} of={props}>{children}</Part>
}
export function ActionTrigger(props: ActionTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getActionTriggerProps',
			propKeys: [
				'action',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Area(props: AreaProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getAreaProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type SeparatorProps =
	(PartProps<'div', Api['getSeparatorProps']>) & { render?: RenderProp<'div'> };
export type ActionTriggerProps =
	(PartProps<'button', Api['getActionTriggerProps']>) & { render?: RenderProp<'button'> };
export type AreaProps = (PartProps<'div', Api['getAreaProps']>) & { render?: RenderProp<'div'> };

export const Timer = { Root, RootProvider, Control, Item, Separator, ActionTrigger, Area, Context };
