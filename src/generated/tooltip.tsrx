import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTooltip } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useTooltip;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	configKeys: [
		'aria-label',
		'closeDelay',
		'closeOnClick',
		'closeOnEscape',
		'closeOnPointerDown',
		'closeOnScroll',
		'defaultOpen',
		'disabled',
		'id',
		'ids',
		'interactive',
		'onOpenChange',
		'open',
		'openDelay',
		'positioning',
		'triggerValue',
		'defaultTriggerValue',
		'onTriggerValueChange',
	],

	useMachine: useTooltip as any,
});
export const RootProvider = createRootProvider({ context });
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const Arrow = createPart({ context, defaultTag: 'div', getter: 'getArrowProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const Trigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'value',
	],
});
export const ArrowTip = createPart({ context, defaultTag: 'div', getter: 'getArrowTipProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type PositionerProps = ArkPartProps;
export type ArrowProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ArrowTipProps = ArkPartProps;

export const Tooltip = {
	Root,
	RootProvider,
	Positioner,
	Arrow,
	Content,
	Trigger,
	ArrowTip,
	Context,
};
