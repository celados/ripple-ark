import {
	Context as RippleContext,
	effect,
	track,
	createRefKey,
	type Children,
	type Tracked,
} from 'ripple';

import { usePopover } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	usePresenceState,
	PRESENCE_KEYS,
	createRenderContent,
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
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
			presence: presenceContext,
			presenceProps: (state) => ({ 'aria-controls': state.unmounted && null }),
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Content(props: ContentProps) @{
	let &{ children, ref } = props;
	const presence = usePresenceState(presenceContext);
	const presenceRefKey = createRefKey();
	let applyPresenceRef = (node: any) => {
		presence.value.setNode(node);
		if (typeof ref === 'function') ref(node);
	};
	const mergedProps = usePartProps(
		{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] },
		props,
	);
	@if (!presence.value.unmounted) {
		@if (props.render) {
			const Content = createRenderContent(
				track(() => ({ ...mergedProps.value, [presenceRefKey]: applyPresenceRef })),
				props.render,
			);
			<{Content} />
		} @else {
			<div {...mergedProps.value} ref={applyPresenceRef}>{children}</div>
		}
	}
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		@if (props.render) {
			const Content = createRenderContent(mergedProps, props.render);
			<{Content} />
		} @else {
			<div {...mergedProps.value}>{children}</div>
		}
	}
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDescriptionProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Anchor(props: AnchorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getAnchorProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCloseTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
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
