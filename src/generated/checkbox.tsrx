import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCheckbox } from '../components';
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

type Hook = typeof useCheckbox;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'checked',
				'defaultChecked',
				'disabled',
				'form',
				'id',
				'ids',
				'invalid',
				'name',
				'onCheckedChange',
				'readOnly',
				'required',
				'value',
			],

			useMachine: useCheckbox as any,
		},
		props,
	);
	<label {...mergedProps.value}>{children}</label>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function HiddenInput(props: HiddenInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function GroupProvider(props: GroupProviderProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			propKeys: [
				'value',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Group(props: GroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			propKeys: [
				'defaultValue',
				'value',
				'onValueChange',
				'disabled',
				'invalid',
				'readOnly',
				'name',
				'maxSelectedValues',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Indicator(props: IndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getIndicatorProps',
			propKeys: [
				'indeterminate',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'label'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'label'> & { value: ReturnType<Hook> };
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type GroupProviderProps = ArkPartProps<'div'>;
export type GroupProps = ArkPartProps<'div'>;
export type LabelProps = PartProps<'span', Api['getLabelProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;

export const Checkbox = {
	Root,
	RootProvider,
	HiddenInput,
	Control,
	GroupProvider,
	Group,
	Label,
	Indicator,
	Context,
};
