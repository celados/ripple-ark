import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePinInput } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof usePinInput;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
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
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Input(props: InputProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getInputProps',
			propKeys: [
				'index',
			],
		},
		props,
	);
	<input {...mergedProps.value} />
}
export function HiddenInput(props: HiddenInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;

export const PinInput = { Root, RootProvider, Label, Control, Input, HiddenInput, Context };
