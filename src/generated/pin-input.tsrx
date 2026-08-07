import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePinInput } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof usePinInput;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'autoFocus',
		'autoSubmit',
		'blurOnComplete',
		'count',
		'defaultValue',
		'disabled',
		'form',
		'id',
		'ids',
		'invalid',
		'mask',
		'name',
		'onValueChange',
		'onValueComplete',
		'onValueInvalid',
		'otp',
		'pattern',
		'placeholder',
		'readOnly',
		'required',
		'sanitizeValue',
		'selectOnFocus',
		'translations',
		'type',
		'value',
	],

	useMachine: usePinInput as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Input = createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
	propKeys: [
		'index',
	],
});
export const HiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type LabelProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;

export const PinInput = { Root, RootProvider, Label, Control, Input, HiddenInput, Context };
