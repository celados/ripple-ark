import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { connectStack, createStack, type DrawerStack } from '@zag-js/drawer';
import { normalizeProps } from '@celados/ripple-zag';
import { useDrawer } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useDrawer;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);
const drawerStackStore = new RippleContext<DrawerStack | null>(null);
const drawerStackApi = new RippleContext<Tracked<AnyRecord> | null>(null);

export const Root = createRoot({
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

	useMachine: useDrawer as any,
});
export const RootProvider = createRootProvider({ context });
export const SwipeArea = createPart({ context, defaultTag: 'div', getter: 'getSwipeAreaProps' });
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const Backdrop = createPart({ context, defaultTag: 'div', getter: 'getBackdropProps' });
export const IndentBackground = createExternalPart({
	context: drawerStackApi,
	defaultTag: 'div',
	getter: 'getIndentBackgroundProps',
});
export const Content = createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
	propKeys: [
		'draggable',
	],
});
export const Trigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'value',
	],
});
export const CloseTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getCloseTriggerProps',
});
export const GrabberIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getGrabberIndicatorProps',
});
export const Indent = createExternalPart({
	context: drawerStackApi,
	defaultTag: 'div',
	getter: 'getIndentProps',
});
export const Grabber = createPart({ context, defaultTag: 'div', getter: 'getGrabberProps' });
export const Title = createPart({ context, defaultTag: 'h2', getter: 'getTitleProps' });
export const Description = createPart({
	context,
	defaultTag: 'div',
	getter: 'getDescriptionProps',
});

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
export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type SwipeAreaProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type BackdropProps = ArkPartProps;
export type IndentBackgroundProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type CloseTriggerProps = ArkPartProps;
export type GrabberIndicatorProps = ArkPartProps;
export type IndentProps = ArkPartProps;
export type GrabberProps = ArkPartProps;
export type TitleProps = ArkPartProps;
export type DescriptionProps = ArkPartProps;

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
