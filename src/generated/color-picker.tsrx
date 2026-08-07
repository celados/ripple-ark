import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useColorPicker } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useColorPicker;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const colorPickerSwatchProps = new RippleContext<Record<string, any> | null>(null);
const colorPickerFormatProps = new RippleContext<Record<string, any> | null>(null);
const colorPickerChannelProps = new RippleContext<Record<string, any> | null>(null);
const colorPickerAreaProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'closeOnSelect',
		'defaultOpen',
		'defaultValue',
		'defaultFormat',
		'disabled',
		'format',
		'id',
		'ids',
		'initialFocusEl',
		'invalid',
		'name',
		'name',
		'onFocusOutside',
		'onFormatChange',
		'onInteractOutside',
		'onOpenChange',
		'onPointerDownOutside',
		'onValueChange',
		'onValueChangeEnd',
		'open',
		'openAutoFocus',
		'positioning',
		'readOnly',
		'required',
		'inline',
		'value',
	],

	useMachine: useColorPicker as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const ValueSwatch = createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchProps',
	propKeys: [
		'respectAlpha',
	],
	provideProps: colorPickerSwatchProps,
});
export const FormatSelect = createPart({
	context,
	defaultTag: 'select',
	getter: 'getFormatSelectProps',
});
export const Swatch = createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchProps',
	propKeys: [
		'respectAlpha',
		'value',
	],
	provideProps: colorPickerSwatchProps,
});
export const SwatchGroup = createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchGroupProps',
});
export const ChannelSliderThumb = createPart({
	context,
	defaultTag: 'div',
	getter: 'getChannelSliderThumbProps',
	inheritedProps: colorPickerFormatProps,
});
export const SwatchTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getSwatchTriggerProps',
	propKeys: [
		'value',
		'disabled',
	],
});
export const View = createPart({
	context,
	defaultTag: 'div',
	propKeys: [
		'format',
	],
	provideProps: colorPickerFormatProps,
});
export const EyeDropperTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getEyeDropperTriggerProps',
});
export const ChannelSlider = createPart({
	context,
	defaultTag: 'div',
	getter: 'getChannelSliderProps',
	propKeys: [
		'channel',
		'orientation',
	],
	provideProps: colorPickerChannelProps,
	inheritedProps: colorPickerFormatProps,
});
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const FormatTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getFormatTriggerProps',
});
export const AreaThumb = createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaThumbProps',
	inheritedProps: colorPickerAreaProps,
});
export const Trigger = createPart({ context, defaultTag: 'button', getter: 'getTriggerProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const ChannelSliderLabel = createPart({
	context,
	defaultTag: 'label',
	getter: 'getChannelSliderLabelProps',
	inheritedProps: colorPickerChannelProps,
});
export const ValueText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getValueTextProps',
	propKeys: [
		'format',
	],
});
export const ChannelSliderValueText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getChannelSliderValueTextProps',
	inheritedProps: colorPickerChannelProps,
});
export const SwatchIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchIndicatorProps',
	inheritedProps: colorPickerSwatchProps,
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const ChannelSliderTrack = createPart({
	context,
	defaultTag: 'div',
	getter: 'getChannelSliderTrackProps',
	inheritedProps: colorPickerFormatProps,
});
export const ChannelInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getChannelInputProps',
	propKeys: [
		'channel',
		'orientation',
	],
});
export const HiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const Area = createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaProps',
	propKeys: [
		'xChannel',
		'yChannel',
	],
	provideProps: colorPickerAreaProps,
});
export const TransparencyGrid = createPart({
	context,
	defaultTag: 'div',
	getter: 'getTransparencyGridProps',
	propKeys: [
		'size',
	],
});
export const AreaBackground = createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaBackgroundProps',
	inheritedProps: colorPickerAreaProps,
});

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type PositionerProps = ArkPartProps;
export type ValueSwatchProps = ArkPartProps;
export type FormatSelectProps = ArkPartProps;
export type SwatchProps = ArkPartProps;
export type SwatchGroupProps = ArkPartProps;
export type ChannelSliderThumbProps = ArkPartProps;
export type SwatchTriggerProps = ArkPartProps;
export type ViewProps = ArkPartProps;
export type EyeDropperTriggerProps = ArkPartProps;
export type ChannelSliderProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type FormatTriggerProps = ArkPartProps;
export type AreaThumbProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type ChannelSliderLabelProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type ChannelSliderValueTextProps = ArkPartProps;
export type SwatchIndicatorProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type ChannelSliderTrackProps = ArkPartProps;
export type ChannelInputProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;
export type AreaProps = ArkPartProps;
export type TransparencyGridProps = ArkPartProps;
export type AreaBackgroundProps = ArkPartProps;

export const ColorPicker = {
	Root,
	RootProvider,
	Positioner,
	ValueSwatch,
	FormatSelect,
	Swatch,
	SwatchGroup,
	ChannelSliderThumb,
	SwatchTrigger,
	View,
	EyeDropperTrigger,
	ChannelSlider,
	Label,
	FormatTrigger,
	AreaThumb,
	Trigger,
	Content,
	ChannelSliderLabel,
	ValueText,
	ChannelSliderValueText,
	SwatchIndicator,
	Control,
	ChannelSliderTrack,
	ChannelInput,
	HiddenInput,
	Area,
	TransparencyGrid,
	AreaBackground,
	Context,
};
