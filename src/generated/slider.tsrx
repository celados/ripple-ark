import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSlider } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useSlider;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const sliderThumbProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
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
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const HiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
	inheritedProps: sliderThumbProps,
});
export const Track = createPart({ context, defaultTag: 'div', getter: 'getTrackProps' });
export const MarkerGroup = createPart({
	context,
	defaultTag: 'div',
	getter: 'getMarkerGroupProps',
});
export const ValueText = createPart({ context, defaultTag: 'span', getter: 'getValueTextProps' });
export const Range = createPart({ context, defaultTag: 'div', getter: 'getRangeProps' });
export const Marker = createPart({
	context,
	defaultTag: 'span',
	getter: 'getMarkerProps',
	propKeys: [
		'value',
	],
});
export const Thumb = createPart({
	context,
	defaultTag: 'div',
	getter: 'getThumbProps',
	propKeys: [
		'index',
		'name',
	],
	provideProps: sliderThumbProps,
});
export const DraggingIndicator = createPart({
	context,
	defaultTag: 'span',
	getter: 'getDraggingIndicatorProps',
	inheritedProps: sliderThumbProps,
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type LabelProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;
export type TrackProps = ArkPartProps;
export type MarkerGroupProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type RangeProps = ArkPartProps;
export type MarkerProps = ArkPartProps;
export type ThumbProps = ArkPartProps;
export type DraggingIndicatorProps = ArkPartProps;
export type ControlProps = ArkPartProps;

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
