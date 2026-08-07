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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context });
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'value',
	],
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
});
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const ArrowTip = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowTipProps',
});
export const Description = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getDescriptionProps',
});
export const Anchor = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getAnchorProps',
});
export const Arrow = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowProps',
});
export const CloseTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getCloseTriggerProps',
});
export const Title = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getTitleProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

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
