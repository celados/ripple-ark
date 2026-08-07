import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDialog } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useDialog;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	configKeys: [
		'aria-label',
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
		'preventScroll',
		'restoreFocus',
		'role',
		'trapFocus',
		'triggerValue',
		'defaultTriggerValue',
		'onTriggerValueChange',
	],

	useMachine: useDialog as any,
});
export const RootProvider = createRootProvider({ context });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const Title = createPart({ context, defaultTag: 'h2', getter: 'getTitleProps' });
export const Trigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'value',
	],
});
export const Backdrop = createPart({ context, defaultTag: 'div', getter: 'getBackdropProps' });
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const CloseTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getCloseTriggerProps',
});
export const Description = createPart({
	context,
	defaultTag: 'div',
	getter: 'getDescriptionProps',
});

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ContentProps = ArkPartProps;
export type TitleProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type BackdropProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type CloseTriggerProps = ArkPartProps;
export type DescriptionProps = ArkPartProps;

export const Dialog = {
	Root,
	RootProvider,
	Content,
	Title,
	Trigger,
	Backdrop,
	Positioner,
	CloseTrigger,
	Description,
	Context,
};
