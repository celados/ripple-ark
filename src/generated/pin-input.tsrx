import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePinInput } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	createRenderContent,
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<label {...mergedProps.value}>{children}</label>
	}
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Input(props: InputProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<input {...mergedProps.value} />
	}
}
export function HiddenInput(props: HiddenInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<input {...mergedProps.value} />
	}
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
