import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePopover } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	PRESENCE_KEYS,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
	type PresenceState,
} from '../binding-runtime.tsrx';

type Hook = typeof usePopover;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	// Rootless upstream: the call runs for its machine/context side effects only.
	useRootProps(
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
			omitKeys: PRESENCE_KEYS,

			useMachine: usePopover as any,
		},
		props,
	);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
			presence: presenceContext,
			presenceProps: (state) => ({ 'aria-controls': state.unmounted && null }),
		}}
		of={props}
	>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] }}
		presence={presenceContext}
		gate
		composeRef
		of={props}
	>{children}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getIndicatorProps' }} of={props}>{children}</Part>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getPositionerProps' }}
		presence={presenceContext}
		gate
		of={props}
	>{children}</Part>
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowTipProps' }} of={props}>{children}</Part>
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getDescriptionProps' }} of={props}>{children}</Part>
}
export function Anchor(props: AnchorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getAnchorProps' }} of={props}>{children}</Part>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowProps' }} of={props}>{children}</Part>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getCloseTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getTitleProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ComponentProps & NonNullable<Parameters<Hook>[0]> & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type RootProviderProps =
	ComponentProps & { value: ReturnType<Hook> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type IndicatorProps =
	(PartProps<'div', Api['getIndicatorProps']>) & { render?: RenderProp<'div'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type ArrowTipProps =
	(PartProps<'div', Api['getArrowTipProps']>) & { render?: RenderProp<'div'> };
export type DescriptionProps =
	(PartProps<'div', Api['getDescriptionProps']>) & { render?: RenderProp<'div'> };
export type AnchorProps =
	(PartProps<'div', Api['getAnchorProps']>) & { render?: RenderProp<'div'> };
export type ArrowProps = (PartProps<'div', Api['getArrowProps']>) & { render?: RenderProp<'div'> };
export type CloseTriggerProps =
	(PartProps<'button', Api['getCloseTriggerProps']>) & { render?: RenderProp<'button'> };
export type TitleProps = (PartProps<'div', Api['getTitleProps']>) & { render?: RenderProp<'div'> };

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
