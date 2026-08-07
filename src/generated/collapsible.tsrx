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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
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

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type TriggerProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;

export const Collapsible = { Root, RootProvider, Trigger, Content, Indicator, Context };
