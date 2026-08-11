import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNumberInput } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context, getter: 'getValueTextProps' }} of={props}>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function IncrementTrigger(props: IncrementTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getIncrementTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function DecrementTrigger(props: DecrementTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getDecrementTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Scrubber(props: ScrubberProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getScrubberProps' }} of={props}>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part tag="input" options={{ context, getter: 'getInputProps' }} of={props} />
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
