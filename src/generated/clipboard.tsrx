import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useClipboard } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useClipboard;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'defaultValue',
		'id',
		'ids',
		'onStatusChange',
		'onValueChange',
		'timeout',
		'translations',
		'value',
	],

	useMachine: useClipboard as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const ValueText = /*#__PURE__*/ createPart({ context, defaultTag: 'span' });
export const Input = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
	propKeys: [
		'copied',
	],
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ValueTextProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type LabelProps = ArkPartProps;

export const Clipboard = {
	Root,
	RootProvider,
	ValueText,
	Input,
	Control,
	Trigger,
	Indicator,
	Label,
	Context,
};
