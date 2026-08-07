import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTimer } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useTimer;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'id',
		'ids',
		'autoStart',
		'interval',
		'countdown',
		'startMs',
		'targetMs',
		'translations',
		'onComplete',
		'onTick',
	],

	useMachine: useTimer as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'type',
	],
});
export const Separator = createPart({ context, defaultTag: 'div', getter: 'getSeparatorProps' });
export const ActionTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getActionTriggerProps',
	propKeys: [
		'action',
	],
});
export const Area = createPart({ context, defaultTag: 'div', getter: 'getAreaProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ControlProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type SeparatorProps = ArkPartProps;
export type ActionTriggerProps = ArkPartProps;
export type AreaProps = ArkPartProps;

export const Timer = { Root, RootProvider, Control, Item, Separator, ActionTrigger, Area, Context };
