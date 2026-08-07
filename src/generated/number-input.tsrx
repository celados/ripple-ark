import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNumberInput } from '../components.ts';
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

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
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
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const ValueText = createPart({ context, defaultTag: 'span', getter: 'getValueTextProps' });
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const IncrementTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getIncrementTriggerProps',
});
export const DecrementTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getDecrementTriggerProps',
});
export const Scrubber = createPart({ context, defaultTag: 'div', getter: 'getScrubberProps' });
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Input = createPart({ context, defaultTag: 'input', getter: 'getInputProps' });

export const Context = createApiContext(context);

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
