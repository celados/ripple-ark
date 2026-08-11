import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import type { ColorStringFormat } from '@zag-js/color-utils';
import { useColorPicker } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	usePresenceState,
	PRESENCE_KEYS,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type PresenceState,
} from '../binding-runtime.tsrx';

type Hook = typeof useColorPicker;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

const colorPickerSwatchProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);
const colorPickerFormatProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);
const colorPickerChannelProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);
const colorPickerAreaProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
			omitKeys: PRESENCE_KEYS,

			useMachine: useColorPicker as any,
		},
		props,
	);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ValueSwatch(props: ValueSwatchProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getFormatSelectProps' }, props);
	<select {...mergedProps.value}>{children}</select>
}
export function Swatch(props: SwatchProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSwatchGroupProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ChannelSliderThumb(props: ChannelSliderThumbProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getChannelSliderThumbProps',
			inheritedProps: [colorPickerFormatProps, colorPickerChannelProps],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function SwatchTrigger(props: SwatchTriggerProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getEyeDropperTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function ChannelSlider(props: ChannelSliderProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function FormatTrigger(props: FormatTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getFormatTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function AreaThumb(props: AreaThumbProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getAreaThumbProps', inheritedProps: colorPickerAreaProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Content(props: ContentProps) @{
	let &{ children, ref } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps(
		{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] },
		props,
	);
	@if (!presence.value.unmounted) {
		<div
			{...mergedProps.value}
			ref={(node) => {
				presence.value.setNode(node);
				if (typeof ref === 'function') ref(node);
			}}
		>{children}</div>
	}
}
export function ChannelSliderLabel(props: ChannelSliderLabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getChannelSliderLabelProps', inheritedProps: colorPickerChannelProps },
		props,
	);
	<label {...mergedProps.value}>{children}</label>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
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
	<span {...mergedProps.value}>
		{children ||
			((props as any).format
				? api.value.value.toString((props as any).format)
				: api.value.valueAsString)}
	</span>
}
export function ChannelSliderValueText(props: ChannelSliderValueTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getChannelSliderValueTextProps', inheritedProps: colorPickerChannelProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function SwatchIndicator(props: SwatchIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getSwatchIndicatorProps', inheritedProps: colorPickerSwatchProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ChannelSliderTrack(props: ChannelSliderTrackProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getChannelSliderTrackProps',
			inheritedProps: [colorPickerFormatProps, colorPickerChannelProps],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ChannelInput(props: ChannelInputProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Area(props: AreaProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getAreaBackgroundProps', inheritedProps: colorPickerAreaProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
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
export type ValueTextProps =
	PartProps<'span', Api['getValueTextProps']> & { format?: ColorStringFormat };
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
