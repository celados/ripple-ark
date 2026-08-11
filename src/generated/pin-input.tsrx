import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePinInput } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof usePinInput;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part
		tag="input"
		options={{
			context,
			getter: 'getInputProps',
			propKeys: [
				'index',
			],
		}}
		of={props}
	/>
}
export function HiddenInput(props: HiddenInputProps) @{
	<Part tag="input" options={{ context, getter: 'getHiddenInputProps' }} of={props} />
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };

export const PinInput = { Root, RootProvider, Label, Control, Input, HiddenInput, Context };
