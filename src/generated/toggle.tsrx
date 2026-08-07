import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useToggle } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useToggle;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'button',
	configKeys: [
		'pressed',
		'defaultPressed',
		'disabled',
		'onPressedChange',
	],

	useMachine: useToggle as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'button' });
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type IndicatorProps = ArkPartProps;

export const Toggle = { Root, RootProvider, Indicator, Context };
