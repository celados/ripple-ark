import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSlider } from '../components';
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
export function HiddenInput(props: HiddenInputProps) @{
	<Part
		tag="input"
		options={{ context, getter: 'getHiddenInputProps', inheritedProps: sliderThumbProps }}
		of={props}
	/>
}
export function Track(props: TrackProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getTrackProps' }} of={props}>{children}</Part>
}
export function MarkerGroup(props: MarkerGroupProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getMarkerGroupProps' }} of={props}>{children}</Part>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	<Part tag="span" options={{ context, getter: 'getValueTextProps' }} of={props}>
		{children || api.value.value.join(',')}
	</Part>
}
export function Range(props: RangeProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getRangeProps' }} of={props}>{children}</Part>
}
export function Marker(props: MarkerProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{
			context,
			getter: 'getMarkerProps',
			propKeys: [
				'value',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Thumb(props: ThumbProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getThumbProps',
			propKeys: [
				'index',
				'name',
			],
			provideProps: sliderThumbProps,
		}}
		of={props}
	>{children}</Part>
}
export function DraggingIndicator(props: DraggingIndicatorProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const thumbProps = sliderThumbProps.get()!;
	<Part
		tag="span"
		options={{ context, getter: 'getDraggingIndicatorProps', inheritedProps: sliderThumbProps }}
		of={props}
	>
		{children || api.value.getThumbValue(thumbProps.value.index)}
	</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type HiddenInputProps = (ArkPartProps<'input'>) & { render?: RenderProp<'input'> };
export type TrackProps = (PartProps<'div', Api['getTrackProps']>) & { render?: RenderProp<'div'> };
export type MarkerGroupProps =
	(PartProps<'div', Api['getMarkerGroupProps']>) & { render?: RenderProp<'div'> };
export type ValueTextProps =
	(PartProps<'span', Api['getValueTextProps']>) & { render?: RenderProp<'span'> };
export type RangeProps = (PartProps<'div', Api['getRangeProps']>) & { render?: RenderProp<'div'> };
export type MarkerProps =
	(PartProps<'span', Api['getMarkerProps']>) & { render?: RenderProp<'span'> };
export type ThumbProps = (PartProps<'div', Api['getThumbProps']>) & { render?: RenderProp<'div'> };
export type DraggingIndicatorProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };

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
