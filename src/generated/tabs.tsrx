import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTabs } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useTabs;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'activationMode',
		'composite',
		'defaultValue',
		'deselectable',
		'id',
		'ids',
		'loopFocus',
		'navigate',
		'onFocusChange',
		'onValueChange',
		'orientation',
		'translations',
		'value',
	],

	useMachine: useTabs as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Content = createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
	propKeys: [
		'value',
	],
});
export const Trigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'disabled',
		'value',
	],
});
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });
export const List = createPart({ context, defaultTag: 'div', getter: 'getListProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ContentProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type ListProps = ArkPartProps;

export const Tabs = { Root, RootProvider, Content, Trigger, Indicator, List, Context };
