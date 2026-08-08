import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePopover } from '../components';
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

type Hook = typeof usePopover;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'autoFocus',
				'closeOnEscape',
				'closeOnInteractOutside',
				'defaultOpen',
				'finalFocusEl',
				'id',
				'ids',
				'initialFocusEl',
				'modal',
				'onEscapeKeyDown',
				'onFocusOutside',
				'onInteractOutside',
				'onOpenChange',
				'onPointerDownOutside',
				'onRequestDismiss',
				'open',
				'persistentElements',
				'portalled',
				'positioning',
				'restoreFocus',
				'translations',
				'triggerValue',
				'defaultTriggerValue',
				'onTriggerValueChange',
			],

			useMachine: usePopover as any,
		},
		props,
	);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<>
		{children}
	</>
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
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDescriptionProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Anchor(props: AnchorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getAnchorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCloseTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ComponentProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ComponentProps & { value: ReturnType<Hook> };
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ArrowTipProps = PartProps<'div', Api['getArrowTipProps']>;
export type DescriptionProps = PartProps<'div', Api['getDescriptionProps']>;
export type AnchorProps = PartProps<'div', Api['getAnchorProps']>;
export type ArrowProps = PartProps<'div', Api['getArrowProps']>;
export type CloseTriggerProps = PartProps<'button', Api['getCloseTriggerProps']>;
export type TitleProps = PartProps<'div', Api['getTitleProps']>;

export const Popover = {
	Root,
	RootProvider,
	Trigger,
	Content,
	Indicator,
	Positioner,
	ArrowTip,
	Description,
	Anchor,
	Arrow,
	CloseTrigger,
	Title,
	Context,
};
