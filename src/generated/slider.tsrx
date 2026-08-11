import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSlider } from '../components';
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
export function HiddenInput(props: HiddenInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getHiddenInputProps', inheritedProps: sliderThumbProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<input {...mergedProps.value} />
	}
}
export function Track(props: TrackProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTrackProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function MarkerGroup(props: MarkerGroupProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getMarkerGroupProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children || api.value.value.join(',')}</span>
	}
}
export function Range(props: RangeProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getRangeProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function DraggingIndicator(props: DraggingIndicatorProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const thumbProps = sliderThumbProps.get()!;
	const mergedProps = usePartProps(
		{ context, getter: 'getDraggingIndicatorProps', inheritedProps: sliderThumbProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>
			{children || api.value.getThumbValue(thumbProps.value.index)}
		</span>
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
