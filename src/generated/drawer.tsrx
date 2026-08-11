import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { connectStack, createStack, type DrawerStack } from '@zag-js/drawer';
import { normalizeProps } from '@celados/ripple-zag';
import { useDrawer } from '../components';
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
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type PresenceState,
} from '../binding-runtime.tsrx';

type Hook = typeof useDrawer;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);
const drawerStackStore = /*#__PURE__*/ new RippleContext<DrawerStack | null>(null);
const drawerStackApi = /*#__PURE__*/ new RippleContext<Tracked<AnyRecord> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	// Rootless upstream: the call runs for its machine/context side effects only.
	useRootProps(
		{
			context,
			configKeys: [
				'id',
				'ids',
				'open',
				'defaultOpen',
				'onOpenChange',
				'closeOnInteractOutside',
				'closeOnEscape',
				'snapPoints',
				'swipeDirection',
				'snapToSequentialPoints',
				'swipeVelocityThreshold',
				'closeThreshold',
				'preventDragOnScroll',
				'stack',
				'snapPoint',
				'defaultSnapPoint',
				'onSnapPointChange',
				'modal',
				'trapFocus',
				'restoreFocus',
				'preventScroll',
				'initialFocusEl',
				'finalFocusEl',
				'role',
				'onInteractOutside',
				'onEscapeKeyDown',
				'onPointerDownOutside',
				'onFocusOutside',
				'onRequestDismiss',
				'triggerValue',
				'defaultTriggerValue',
				'onTriggerValueChange',
			],
			defaultMachineProps: () => ({ stack: drawerStackStore.get() ?? undefined }),
			omitKeys: PRESENCE_KEYS,

			useMachine: useDrawer as any,
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
export function SwipeArea(props: SwipeAreaProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSwipeAreaProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Backdrop(props: BackdropProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getBackdropProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function IndentBackground(props: IndentBackgroundProps) @{
	let &{ children } = props;
	const mergedProps = useExternalPartProps(
		{ context: drawerStackApi, getter: 'getIndentBackgroundProps' },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	let &{ children, ref } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getContentProps',
			propKeys: [
				'draggable',
			],
			presence: presenceContext,
			omitKeys: ['ref'],
		},
		props,
	);
	@if (!presence.value.unmounted) {
		<div
			{...mergedProps.value}
			ref={(node) => {
				presence.value.setNode(node);
				if (typeof ref === 'function') ref(node);
			}}
		>{children}</div>
	}
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
	<button {...mergedProps.value}>{children}</button>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCloseTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function GrabberIndicator(props: GrabberIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getGrabberIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Indent(props: IndentProps) @{
	let &{ children } = props;
	const mergedProps = useExternalPartProps(
		{ context: drawerStackApi, getter: 'getIndentProps' },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Grabber(props: GrabberProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getGrabberProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	<h2 {...mergedProps.value}>{children}</h2>
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDescriptionProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export function Stack(props: { children?: Children | Children[] }) @{
	const store = createStack();
	const revision = track(0);
	effect(
		() => store.subscribe(() => {
			revision.value += 1;
		}),
	);
	const api = track(() => {
		revision.value;
		return connectStack(store.getSnapshot(), normalizeProps) as AnyRecord;
	});
	drawerStackStore.set(store);
	drawerStackApi.set(api);
	{
		props.children;
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
export type SwipeAreaProps = PartProps<'div', Api['getSwipeAreaProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type BackdropProps = PartProps<'div', Api['getBackdropProps']>;
export type IndentBackgroundProps = ArkPartProps<'div'>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type CloseTriggerProps = PartProps<'button', Api['getCloseTriggerProps']>;
export type GrabberIndicatorProps = PartProps<'div', Api['getGrabberIndicatorProps']>;
export type IndentProps = ArkPartProps<'div'>;
export type GrabberProps = PartProps<'div', Api['getGrabberProps']>;
export type TitleProps = PartProps<'h2', Api['getTitleProps']>;
export type DescriptionProps = PartProps<'div', Api['getDescriptionProps']>;

export const Drawer = {
	Root,
	RootProvider,
	SwipeArea,
	Positioner,
	Backdrop,
	IndentBackground,
	Content,
	Trigger,
	CloseTrigger,
	GrabberIndicator,
	Indent,
	Grabber,
	Title,
	Description,
	Stack,
	Context,
};
