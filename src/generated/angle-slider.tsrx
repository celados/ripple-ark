import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAngleSlider } from '../components';
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

type Hook = typeof useAngleSlider;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Thumb(props: ThumbProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getThumbProps' }} of={props}>{children}</Part>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	<Part tag="div" options={{ context, getter: 'getValueTextProps' }} of={props}>
		{children || api.value.valueAsDegree}
	</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function MarkerGroup(props: MarkerGroupProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getMarkerGroupProps' }} of={props}>{children}</Part>
}
export function Marker(props: MarkerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
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
export function HiddenInput(props: HiddenInputProps) @{
	<Part tag="input" options={{ context, getter: 'getHiddenInputProps' }} of={props} />
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
export type ThumbProps = (PartProps<'div', Api['getThumbProps']>) & { render?: RenderProp<'div'> };
export type ValueTextProps =
	(PartProps<'div', Api['getValueTextProps']>) & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type MarkerGroupProps =
	(PartProps<'div', Api['getMarkerGroupProps']>) & { render?: RenderProp<'div'> };
export type MarkerProps =
	(PartProps<'div', Api['getMarkerProps']>) & { render?: RenderProp<'div'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };

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
