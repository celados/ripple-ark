import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTooltip } from '../components';
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

type Hook = typeof useTooltip;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'aria-label',
				'closeDelay',
				'closeOnClick',
				'closeOnEscape',
				'closeOnPointerDown',
				'closeOnScroll',
				'defaultOpen',
				'disabled',
				'id',
				'ids',
				'interactive',
				'onOpenChange',
				'open',
				'openDelay',
				'positioning',
				'triggerValue',
				'defaultTriggerValue',
				'onTriggerValueChange',
			],

			useMachine: useTooltip as any,
		},
		props,
	);
	{
		children;
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	{
		children;
	}
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
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
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ComponentProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ComponentProps & { value: ReturnType<Hook> };
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ArrowProps = PartProps<'div', Api['getArrowProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ArrowTipProps = PartProps<'div', Api['getArrowTipProps']>;

export const Tooltip = {
	Root,
	RootProvider,
	Positioner,
	Arrow,
	Content,
	Trigger,
	ArrowTip,
	Context,
};
