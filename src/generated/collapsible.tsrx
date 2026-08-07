import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCollapsible } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useCollapsible;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'collapsedHeight',
		'collapsedWidth',
		'defaultOpen',
		'disabled',
		'id',
		'ids',
		'lazyMount',
		'onExitComplete',
		'onOpenChange',
		'open',
		'unmountOnExit',
	],

	useMachine: useCollapsible as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Trigger = createPart({ context, defaultTag: 'button', getter: 'getTriggerProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type TriggerProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;

export const Collapsible = { Root, RootProvider, Trigger, Content, Indicator, Context };
