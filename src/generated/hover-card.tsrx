import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useHoverCard } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useHoverCard;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	configKeys: [
		'closeDelay',
		'defaultOpen',
		'disabled',
		'id',
		'ids',
		'onFocusOutside',
		'onInteractOutside',
		'onOpenChange',
		'onPointerDownOutside',
		'open',
		'openDelay',
		'positioning',
		'triggerValue',
		'defaultTriggerValue',
		'onTriggerValueChange',
	],

	useMachine: useHoverCard as any,
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
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const Arrow = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowProps',
});
export const ArrowTip = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowTipProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type TriggerProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type ArrowProps = ArkPartProps;
export type ArrowTipProps = ArkPartProps;

export const HoverCard = {
	Root,
	RootProvider,
	Trigger,
	Content,
	Positioner,
	Arrow,
	ArrowTip,
	Context,
};
