import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAngleSlider } from '../components';
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

type Hook = typeof useAngleSlider;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'id',
				'ids',
				'name',
				'invalid',
				'readOnly',
				'disabled',
				'onValueChangeEnd',
				'onValueChange',
				'defaultValue',
				'value',
				'step',
				'aria-label',
				'aria-labelledby',
			],

			useMachine: useAngleSlider as any,
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
export function Thumb(props: ThumbProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getThumbProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ValueText(props: ValueTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function MarkerGroup(props: MarkerGroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getMarkerGroupProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Marker(props: MarkerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getMarkerProps',
			propKeys: [
				'value',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
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

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ThumbProps = PartProps<'div', Api['getThumbProps']>;
export type ValueTextProps = PartProps<'div', Api['getValueTextProps']>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type MarkerGroupProps = PartProps<'div', Api['getMarkerGroupProps']>;
export type MarkerProps = PartProps<'div', Api['getMarkerProps']>;
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;

export const AngleSlider = {
	Root,
	RootProvider,
	Thumb,
	ValueText,
	Label,
	MarkerGroup,
	Marker,
	HiddenInput,
	Control,
	Context,
};
