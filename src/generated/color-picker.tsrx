import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useColorPicker } from '../components';
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

type Hook = typeof useColorPicker;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const colorPickerSwatchProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const colorPickerFormatProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const colorPickerChannelProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const colorPickerAreaProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
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
export function Positioner(props: PositionerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ValueSwatch(props: ValueSwatchProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getSwatchProps',
			propKeys: [
				'respectAlpha',
			],
			provideProps: colorPickerSwatchProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function FormatSelect(props: FormatSelectProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getFormatSelectProps' }, props);
	<select {...mergedProps.value}>{children}</select>
}
export function Swatch(props: SwatchProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getSwatchProps',
			propKeys: [
				'respectAlpha',
				'value',
			],
			provideProps: colorPickerSwatchProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function SwatchGroup(props: SwatchGroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getSwatchGroupProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ChannelSliderThumb(props: ChannelSliderThumbProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getChannelSliderThumbProps', inheritedProps: colorPickerFormatProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function SwatchTrigger(props: SwatchTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getSwatchTriggerProps',
			propKeys: [
				'value',
				'disabled',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function View(props: ViewProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			propKeys: [
				'format',
			],
			provideProps: colorPickerFormatProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function EyeDropperTrigger(props: EyeDropperTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getEyeDropperTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function ChannelSlider(props: ChannelSliderProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getChannelSliderProps',
			propKeys: [
				'channel',
				'orientation',
			],
			provideProps: colorPickerChannelProps,
			inheritedProps: colorPickerFormatProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function FormatTrigger(props: FormatTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getFormatTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function AreaThumb(props: AreaThumbProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getAreaThumbProps', inheritedProps: colorPickerAreaProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Content(props: ContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ChannelSliderLabel(props: ChannelSliderLabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getChannelSliderLabelProps', inheritedProps: colorPickerChannelProps },
		props,
	);
	<label {...mergedProps.value}>{children}</label>
}
export function ValueText(props: ValueTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getValueTextProps',
			propKeys: [
				'format',
			],
		},
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function ChannelSliderValueText(props: ChannelSliderValueTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getChannelSliderValueTextProps', inheritedProps: colorPickerChannelProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function SwatchIndicator(props: SwatchIndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getSwatchIndicatorProps', inheritedProps: colorPickerSwatchProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ChannelSliderTrack(props: ChannelSliderTrackProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getChannelSliderTrackProps', inheritedProps: colorPickerFormatProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ChannelInput(props: ChannelInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getChannelInputProps',
			propKeys: [
				'channel',
				'orientation',
			],
		},
		props,
	);
	<input {...mergedProps.value} />
}
export function HiddenInput(props: HiddenInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Area(props: AreaProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getAreaProps',
			propKeys: [
				'xChannel',
				'yChannel',
			],
			provideProps: colorPickerAreaProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function TransparencyGrid(props: TransparencyGridProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTransparencyGridProps',
			propKeys: [
				'size',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function AreaBackground(props: AreaBackgroundProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getAreaBackgroundProps', inheritedProps: colorPickerAreaProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ValueSwatchProps = PartProps<'div', Api['getSwatchProps']>;
export type FormatSelectProps = PartProps<'select', Api['getFormatSelectProps']>;
export type SwatchProps = PartProps<'div', Api['getSwatchProps']>;
export type SwatchGroupProps = PartProps<'div', Api['getSwatchGroupProps']>;
export type ChannelSliderThumbProps = ArkPartProps<'div'>;
export type SwatchTriggerProps = PartProps<'button', Api['getSwatchTriggerProps']>;
export type ViewProps = ArkPartProps<'div'>;
export type EyeDropperTriggerProps = PartProps<'button', Api['getEyeDropperTriggerProps']>;
export type ChannelSliderProps =
	ArkPartProps<'div'> & Pick<
		GetterProps<Api['getChannelSliderProps']>,
		Extract<keyof GetterProps<Api['getChannelSliderProps']>, 'channel' | 'orientation'>
	>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type FormatTriggerProps = PartProps<'button', Api['getFormatTriggerProps']>;
export type AreaThumbProps = ArkPartProps<'div'>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type ChannelSliderLabelProps = ArkPartProps<'label'>;
export type ValueTextProps = PartProps<'span', Api['getValueTextProps']>;
export type ChannelSliderValueTextProps = ArkPartProps<'span'>;
export type SwatchIndicatorProps = ArkPartProps<'div'>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type ChannelSliderTrackProps = ArkPartProps<'div'>;
export type ChannelInputProps = PartProps<'input', Api['getChannelInputProps']>;
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;
export type AreaProps = PartProps<'div', Api['getAreaProps']>;
export type TransparencyGridProps = PartProps<'div', Api['getTransparencyGridProps']>;
export type AreaBackgroundProps = ArkPartProps<'div'>;

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
