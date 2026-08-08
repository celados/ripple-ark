import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSlider } from '../components';
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

type Hook = typeof useSlider;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const sliderThumbProps = /*#__PURE__*/ new RippleContext<Tracked<Record<string, any>> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'aria-label',
				'aria-labelledby',
				'defaultValue',
				'disabled',
				'form',
				'getAriaValueText',
				'id',
				'ids',
				'invalid',
				'largeStep',
				'max',
				'min',
				'minStepsBetweenThumbs',
				'name',
				'onFocusChange',
				'onValueChange',
				'onValueChangeEnd',
				'orientation',
				'origin',
				'readOnly',
				'step',
				'thumbAlignment',
				'thumbCollisionBehavior',
				'thumbSize',
				'value',
			],

			useMachine: useSlider as any,
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
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function HiddenInput(props: HiddenInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getHiddenInputProps', inheritedProps: sliderThumbProps },
		props,
	);
	<input {...mergedProps.value} />
}
export function Track(props: TrackProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTrackProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function MarkerGroup(props: MarkerGroupProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getMarkerGroupProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Range(props: RangeProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getRangeProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Marker(props: MarkerProps) @{
	let &{ children } = props;
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
	<span {...mergedProps.value}>{children}</span>
}
export function Thumb(props: ThumbProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getThumbProps',
			propKeys: [
				'index',
				'name',
			],
			provideProps: sliderThumbProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function DraggingIndicator(props: DraggingIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getDraggingIndicatorProps', inheritedProps: sliderThumbProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type HiddenInputProps = ArkPartProps<'input'>;
export type TrackProps = PartProps<'div', Api['getTrackProps']>;
export type MarkerGroupProps = PartProps<'div', Api['getMarkerGroupProps']>;
export type ValueTextProps = PartProps<'span', Api['getValueTextProps']>;
export type RangeProps = PartProps<'div', Api['getRangeProps']>;
export type MarkerProps = PartProps<'span', Api['getMarkerProps']>;
export type ThumbProps = PartProps<'div', Api['getThumbProps']>;
export type DraggingIndicatorProps = ArkPartProps<'span'>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;

export const Slider = {
	Root,
	RootProvider,
	Label,
	HiddenInput,
	Track,
	MarkerGroup,
	ValueText,
	Range,
	Marker,
	Thumb,
	DraggingIndicator,
	Control,
	Context,
};
