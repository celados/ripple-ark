import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePopover } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof usePopover;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
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
});
export const RootProvider = createRootProvider({ context });
export const Trigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'value',
	],
});
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const ArrowTip = createPart({ context, defaultTag: 'div', getter: 'getArrowTipProps' });
export const Description = createPart({
	context,
	defaultTag: 'div',
	getter: 'getDescriptionProps',
});
export const Anchor = createPart({ context, defaultTag: 'div', getter: 'getAnchorProps' });
export const Arrow = createPart({ context, defaultTag: 'div', getter: 'getArrowProps' });
export const CloseTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getCloseTriggerProps',
});
export const Title = createPart({ context, defaultTag: 'div', getter: 'getTitleProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type TriggerProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type ArrowTipProps = ArkPartProps;
export type DescriptionProps = ArkPartProps;
export type AnchorProps = ArkPartProps;
export type ArrowProps = ArkPartProps;
export type CloseTriggerProps = ArkPartProps;
export type TitleProps = ArkPartProps;

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
