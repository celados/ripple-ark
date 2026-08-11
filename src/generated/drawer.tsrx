import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { connectStack, createStack, type DrawerStack } from '@zag-js/drawer';
import { normalizeProps } from '@celados/ripple-zag';
import { useDrawer } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useExternalPartProps,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	usePartPresence,
	provideRenderStrategy,
	PRESENCE_KEYS,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
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
	provideRenderStrategy(props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	provideRenderStrategy(props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function SwipeArea(props: SwipeAreaProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getSwipeAreaProps' }} of={props}>{children}</Part>
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
export function Backdrop(props: BackdropProps) @{
	let &{ children } = props;
	const api = context.get()!;

	const presence = usePartPresence(() => api.value.open);

	<Part
		tag="div"
		options={{ context, getter: 'getBackdropProps', presence, omitKeys: ['ref'] }}
		presence={presence}
		gate
		composeRef
		of={props}
	>{children}</Part>
}
export function IndentBackground(props: IndentBackgroundProps) @{
	let &{ children } = props;
	const mergedProps = useExternalPartProps(
		{ context: drawerStackApi, getter: 'getIndentBackgroundProps' },
		props,
	);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getContentProps',
			propKeys: [
				'draggable',
			],
			presence: presenceContext,
			omitKeys: ['ref'],
		}}
		presence={presenceContext}
		gate
		composeRef
		of={props}
	>{children}</Part>
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
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getCloseTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function GrabberIndicator(props: GrabberIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getGrabberIndicatorProps' }}
		of={props}
	>{children}</Part>
}
export function Indent(props: IndentProps) @{
	let &{ children } = props;
	const mergedProps = useExternalPartProps(
		{ context: drawerStackApi, getter: 'getIndentProps' },
		props,
	);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Grabber(props: GrabberProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getGrabberProps' }} of={props}>{children}</Part>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	<Part tag="h2" options={{ context, getter: 'getTitleProps' }} of={props}>{children}</Part>
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getDescriptionProps' }} of={props}>{children}</Part>
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
export type SwipeAreaProps =
	(PartProps<'div', Api['getSwipeAreaProps']>) & { render?: RenderProp<'div'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type BackdropProps =
	(PartProps<'div', Api['getBackdropProps']>) & { render?: RenderProp<'div'> };
export type IndentBackgroundProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type CloseTriggerProps =
	(PartProps<'button', Api['getCloseTriggerProps']>) & { render?: RenderProp<'button'> };
export type GrabberIndicatorProps =
	(PartProps<'div', Api['getGrabberIndicatorProps']>) & { render?: RenderProp<'div'> };
export type IndentProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type GrabberProps =
	(PartProps<'div', Api['getGrabberProps']>) & { render?: RenderProp<'div'> };
export type TitleProps = (PartProps<'h2', Api['getTitleProps']>) & { render?: RenderProp<'h2'> };
export type DescriptionProps =
	(PartProps<'div', Api['getDescriptionProps']>) & { render?: RenderProp<'div'> };

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
