import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNumberInput } from '../components';
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

type Hook = typeof useNumberInput;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ValueText(props: ValueTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function IncrementTrigger(props: IncrementTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getIncrementTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function DecrementTrigger(props: DecrementTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getDecrementTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Scrubber(props: ScrubberProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getScrubberProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Input(props: InputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getInputProps' }, props);
	<input {...mergedProps.value} />
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ValueTextProps = PartProps<'span', Api['getValueTextProps']>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type IncrementTriggerProps = PartProps<'button', Api['getIncrementTriggerProps']>;
export type DecrementTriggerProps = PartProps<'button', Api['getDecrementTriggerProps']>;
export type ScrubberProps = PartProps<'div', Api['getScrubberProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type InputProps = PartProps<'input', Api['getInputProps']>;

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
