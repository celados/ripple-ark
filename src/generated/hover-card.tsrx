import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useHoverCard } from '../components';
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

type Hook = typeof useHoverCard;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'closeDelay',
				'defaultOpen',
				'disabled',
				'id',
				'ids',
				'onFocusOutside',
				'onInteractOutside',
				'onOpenChange',
				'onPointerDownOutside',
				'open',
				'openDelay',
				'positioning',
				'triggerValue',
				'defaultTriggerValue',
				'onTriggerValueChange',
			],

			useMachine: useHoverCard as any,
		},
		props,
	);
	{
		children;
	}
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	{
		children;
	}
}
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Content(props: ContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Arrow(props: ArrowProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ArrowTip(props: ArrowTipProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ComponentProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ComponentProps & { value: ReturnType<Hook> };
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ArrowProps = PartProps<'div', Api['getArrowProps']>;
export type ArrowTipProps = PartProps<'div', Api['getArrowTipProps']>;

export const HoverCard = {
	Root,
	RootProvider,
	Trigger,
	Content,
	Positioner,
	Arrow,
	ArrowTip,
	Context,
};
