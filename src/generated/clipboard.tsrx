import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useClipboard } from '../components';
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

type Hook = typeof useClipboard;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
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
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const mergedProps = usePartProps({ context }, props);
	<span {...mergedProps.value}>{children || api.value.value}</span>
}
export function Input(props: InputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getIndicatorProps',
			propKeys: [
				'copied',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ValueTextProps = ArkPartProps<'span'>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;

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
