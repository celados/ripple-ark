import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import type { ColorStringFormat } from '@zag-js/color-utils';
import { useColorPicker } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	PRESENCE_KEYS,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getPositionerProps' }}
		presence={presenceContext}
		gate
		of={props}
	>{children}</Part>
}
export function ValueSwatch(props: ValueSwatchProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getSwatchProps',
			propKeys: [
				'respectAlpha',
			],
			provideProps: colorPickerSwatchProps,
		}}
		of={props}
	>{children}</Part>
}
export function FormatSelect(props: FormatSelectProps) @{
	let &{ children } = props;
	<Part
		tag="select"
		options={{ context, getter: 'getFormatSelectProps' }}
		of={props}
	>{children}</Part>
}
export function Swatch(props: SwatchProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getSwatchProps',
			propKeys: [
				'respectAlpha',
				'value',
			],
			provideProps: colorPickerSwatchProps,
		}}
		of={props}
	>{children}</Part>
}
export function SwatchGroup(props: SwatchGroupProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getSwatchGroupProps' }} of={props}>{children}</Part>
}
export function ChannelSliderThumb(props: ChannelSliderThumbProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getChannelSliderThumbProps',
			inheritedProps: [colorPickerFormatProps, colorPickerChannelProps],
		}}
		of={props}
	>{children}</Part>
}
export function SwatchTrigger(props: SwatchTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getSwatchTriggerProps',
			propKeys: [
				'value',
				'disabled',
			],
		}}
		of={props}
	>{children}</Part>
}
export function View(props: ViewProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			propKeys: [
				'format',
			],
			provideProps: colorPickerFormatProps,
		}}
		of={props}
	>{children}</Part>
}
export function EyeDropperTrigger(props: EyeDropperTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getEyeDropperTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function ChannelSlider(props: ChannelSliderProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getChannelSliderProps',
			propKeys: [
				'channel',
				'orientation',
			],
			provideProps: colorPickerChannelProps,
			inheritedProps: colorPickerFormatProps,
		}}
		of={props}
	>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function FormatTrigger(props: FormatTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getFormatTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function AreaThumb(props: AreaThumbProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getAreaThumbProps', inheritedProps: colorPickerAreaProps }}
		of={props}
	>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part tag="button" options={{ context, getter: 'getTriggerProps' }} of={props}>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] }}
		presence={presenceContext}
		gate
		composeRef
		of={props}
	>{children}</Part>
}
export function ChannelSliderLabel(props: ChannelSliderLabelProps) @{
	let &{ children } = props;
	<Part
		tag="label"
		options={{
			context,
			getter: 'getChannelSliderLabelProps',
			inheritedProps: colorPickerChannelProps,
		}}
		of={props}
	>{children}</Part>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	<Part
		tag="span"
		options={{
			context,
			getter: 'getValueTextProps',
			propKeys: [
				'format',
			],
		}}
		of={props}
	>
		{children ||
			((props as any).format
				? api.value.value.toString((props as any).format)
				: api.value.valueAsString)}
	</Part>
}
export function ChannelSliderValueText(props: ChannelSliderValueTextProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{
			context,
			getter: 'getChannelSliderValueTextProps',
			inheritedProps: colorPickerChannelProps,
		}}
		of={props}
	>{children}</Part>
}
export function SwatchIndicator(props: SwatchIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getSwatchIndicatorProps', inheritedProps: colorPickerSwatchProps }}
		of={props}
	>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function ChannelSliderTrack(props: ChannelSliderTrackProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getChannelSliderTrackProps',
			inheritedProps: [colorPickerFormatProps, colorPickerChannelProps],
		}}
		of={props}
	>{children}</Part>
}
export function ChannelInput(props: ChannelInputProps) @{
	<Part
		tag="input"
		options={{
			context,
			getter: 'getChannelInputProps',
			propKeys: [
				'channel',
				'orientation',
			],
		}}
		of={props}
	/>
}
export function HiddenInput(props: HiddenInputProps) @{
	<Part tag="input" options={{ context, getter: 'getHiddenInputProps' }} of={props} />
}
export function Area(props: AreaProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getAreaProps',
			propKeys: [
				'xChannel',
				'yChannel',
			],
			provideProps: colorPickerAreaProps,
		}}
		of={props}
	>{children}</Part>
}
export function TransparencyGrid(props: TransparencyGridProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getTransparencyGridProps',
			propKeys: [
				'size',
			],
		}}
		of={props}
	>{children}</Part>
}
export function AreaBackground(props: AreaBackgroundProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getAreaBackgroundProps', inheritedProps: colorPickerAreaProps }}
		of={props}
	>{children}</Part>
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
	} & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	} & { render?: RenderProp<'div'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type ValueSwatchProps =
	(PartProps<'div', Api['getSwatchProps']>) & { render?: RenderProp<'div'> };
export type FormatSelectProps =
	(PartProps<'select', Api['getFormatSelectProps']>) & { render?: RenderProp<'select'> };
export type SwatchProps =
	(PartProps<'div', Api['getSwatchProps']>) & { render?: RenderProp<'div'> };
export type SwatchGroupProps =
	(PartProps<'div', Api['getSwatchGroupProps']>) & { render?: RenderProp<'div'> };
export type ChannelSliderThumbProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type SwatchTriggerProps =
	(PartProps<'button', Api['getSwatchTriggerProps']>) & { render?: RenderProp<'button'> };
export type ViewProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type EyeDropperTriggerProps =
	(PartProps<'button', Api['getEyeDropperTriggerProps']>) & { render?: RenderProp<'button'> };
export type ChannelSliderProps =
	(ArkPartProps<'div'> & Pick<
		GetterProps<Api['getChannelSliderProps']>,
		Extract<keyof GetterProps<Api['getChannelSliderProps']>, 'channel' | 'orientation'>
	>) & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type FormatTriggerProps =
	(PartProps<'button', Api['getFormatTriggerProps']>) & { render?: RenderProp<'button'> };
export type AreaThumbProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type ChannelSliderLabelProps = (ArkPartProps<'label'>) & { render?: RenderProp<'label'> };
export type ValueTextProps =
	(PartProps<'span', Api['getValueTextProps']> & { format?: ColorStringFormat }) & {
		render?: RenderProp<'span'>;
	};
export type ChannelSliderValueTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type SwatchIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type ChannelSliderTrackProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ChannelInputProps =
	(PartProps<'input', Api['getChannelInputProps']>) & { render?: RenderProp<'input'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type AreaProps = (PartProps<'div', Api['getAreaProps']>) & { render?: RenderProp<'div'> };
export type TransparencyGridProps =
	(PartProps<'div', Api['getTransparencyGridProps']>) & { render?: RenderProp<'div'> };
export type AreaBackgroundProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };

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
