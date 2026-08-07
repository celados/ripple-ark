import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNumberInput } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useNumberInput;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'allowMouseWheel',
		'allowOverflow',
		'clampValueOnBlur',
		'defaultValue',
		'disabled',
		'focusInputOnChange',
		'form',
		'formatOptions',
		'id',
		'ids',
		'inputMode',
		'invalid',
		'largeStep',
		'locale',
		'max',
		'min',
		'name',
		'onFocusChange',
		'onValueChange',
		'onValueCommit',
		'onValueInvalid',
		'pattern',
		'readOnly',
		'required',
		'smallStep',
		'spinOnPress',
		'step',
		'translations',
		'value',
	],

	useMachine: useNumberInput as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const ValueText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getValueTextProps',
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const IncrementTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getIncrementTriggerProps',
});
export const DecrementTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getDecrementTriggerProps',
});
export const Scrubber = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getScrubberProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Input = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ValueTextProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type IncrementTriggerProps = ArkPartProps;
export type DecrementTriggerProps = ArkPartProps;
export type ScrubberProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type InputProps = ArkPartProps;

export const NumberInput = {
	Root,
	RootProvider,
	ValueText,
	Label,
	IncrementTrigger,
	DecrementTrigger,
	Scrubber,
	Control,
	Input,
	Context,
};
