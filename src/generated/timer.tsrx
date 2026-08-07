import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTimer } from '../components';
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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'type',
	],
});
export const Separator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSeparatorProps',
});
export const ActionTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getActionTriggerProps',
	propKeys: [
		'action',
	],
});
export const Area = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ControlProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type SeparatorProps = ArkPartProps;
export type ActionTriggerProps = ArkPartProps;
export type AreaProps = ArkPartProps;

export const Timer = { Root, RootProvider, Control, Item, Separator, ActionTrigger, Area, Context };
