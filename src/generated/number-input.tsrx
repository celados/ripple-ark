import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNumberInput } from '../components';
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

type Hook = typeof useNumberInput;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
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
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
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
export function IncrementTrigger(props: IncrementTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIncrementTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function DecrementTrigger(props: DecrementTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDecrementTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Scrubber(props: ScrubberProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getScrubberProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
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
	const mergedProps = usePartProps({ context, getter: 'getInputProps' }, props);
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
export type ValueTextProps =
	(PartProps<'span', Api['getValueTextProps']>) & { render?: RenderProp<'span'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type IncrementTriggerProps =
	(PartProps<'button', Api['getIncrementTriggerProps']>) & { render?: RenderProp<'button'> };
export type DecrementTriggerProps =
	(PartProps<'button', Api['getDecrementTriggerProps']>) & { render?: RenderProp<'button'> };
export type ScrubberProps =
	(PartProps<'div', Api['getScrubberProps']>) & { render?: RenderProp<'div'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };

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
