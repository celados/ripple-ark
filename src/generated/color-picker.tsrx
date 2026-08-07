import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useColorPicker } from '../components';
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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const colorPickerSwatchProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const colorPickerFormatProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const colorPickerChannelProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const colorPickerAreaProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const ValueSwatch = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchProps',
	propKeys: [
		'respectAlpha',
	],
	provideProps: colorPickerSwatchProps,
});
export const FormatSelect = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'select',
	getter: 'getFormatSelectProps',
});
export const Swatch = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchProps',
	propKeys: [
		'respectAlpha',
		'value',
	],
	provideProps: colorPickerSwatchProps,
});
export const SwatchGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchGroupProps',
});
export const ChannelSliderThumb = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getChannelSliderThumbProps',
	inheritedProps: colorPickerFormatProps,
});
export const SwatchTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getSwatchTriggerProps',
	propKeys: [
		'value',
		'disabled',
	],
});
export const View = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	propKeys: [
		'format',
	],
	provideProps: colorPickerFormatProps,
});
export const EyeDropperTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getEyeDropperTriggerProps',
});
export const ChannelSlider = /*#__PURE__*/ createPart({
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
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const FormatTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getFormatTriggerProps',
});
export const AreaThumb = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaThumbProps',
	inheritedProps: colorPickerAreaProps,
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const ChannelSliderLabel = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getChannelSliderLabelProps',
	inheritedProps: colorPickerChannelProps,
});
export const ValueText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getValueTextProps',
	propKeys: [
		'format',
	],
});
export const ChannelSliderValueText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getChannelSliderValueTextProps',
	inheritedProps: colorPickerChannelProps,
});
export const SwatchIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSwatchIndicatorProps',
	inheritedProps: colorPickerSwatchProps,
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const ChannelSliderTrack = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getChannelSliderTrackProps',
	inheritedProps: colorPickerFormatProps,
});
export const ChannelInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getChannelInputProps',
	propKeys: [
		'channel',
		'orientation',
	],
});
export const HiddenInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const Area = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaProps',
	propKeys: [
		'xChannel',
		'yChannel',
	],
	provideProps: colorPickerAreaProps,
});
export const TransparencyGrid = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getTransparencyGridProps',
	propKeys: [
		'size',
	],
});
export const AreaBackground = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaBackgroundProps',
	inheritedProps: colorPickerAreaProps,
});

export const Context = /*#__PURE__*/ createApiContext(context);

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
