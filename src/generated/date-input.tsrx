import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDateInput } from '../components';
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

type Hook = typeof useDateInput;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const dateInputSegmentGroupProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'disabled',
				'id',
				'ids',
				'invalid',
				'locale',
				'max',
				'min',
				'name',
				'form',
				'onFocusChange',
				'onPlaceholderChange',
				'onValueChange',
				'readOnly',
				'required',
				'selectionMode',
				'timeZone',
				'hideTimeZone',
				'translations',
				'value',
				'defaultValue',
				'hourCycle',
				'granularity',
				'shouldForceLeadingZeros',
				'allSegments',
				'formatter',
				'placeholderValue',
				'defaultPlaceholderValue',
				'format',
				'createCalendar',
				'isDateUnavailable',
			],

			useMachine: useDateInput as any,
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
export function Segment(props: SegmentProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getSegmentProps', inheritedProps: dateInputSegmentGroupProps }}
		of={props}
	>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function SegmentGroup(props: SegmentGroupProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getSegmentGroupProps', provideProps: dateInputSegmentGroupProps }}
		of={props}
	>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function HiddenInput(props: HiddenInputProps) @{
	<Part tag="input" options={{ context, getter: 'getHiddenInputProps' }} of={props} />
}

export function SegmentContext(props: { render: (segment: AnyRecord) => Children }) @{
	const api = context.get();
	const groupProps = dateInputSegmentGroupProps.get();
	if (
		!api || !groupProps
	) throw new Error('DateInput.SegmentContext must be rendered inside SegmentGroup');
	const segments = track(() => api.value.getSegments(groupProps.value));
	@for (const segment of segments.value; index index) {
		const Content = () => props.render({ ...segment, index });
		<{Content} />
	}
}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type SegmentProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type SegmentGroupProps =
	(PartProps<'div', Api['getSegmentGroupProps']>) & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };

export const DateInput = {
	Root,
	RootProvider,
	Segment,
	Control,
	SegmentGroup,
	Label,
	HiddenInput,
	SegmentContext,
	Context,
};
