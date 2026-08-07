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

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
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
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const Arrow = createPart({ context, defaultTag: 'div', getter: 'getArrowProps' });
export const ArrowTip = createPart({ context, defaultTag: 'div', getter: 'getArrowTipProps' });

export const Context = createApiContext(context);

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
