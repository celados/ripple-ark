import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDateInput } from '../components';
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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Segment(props: SegmentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getSegmentProps', inheritedProps: dateInputSegmentGroupProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function SegmentGroup(props: SegmentGroupProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getSegmentGroupProps', provideProps: dateInputSegmentGroupProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function HiddenInput(props: HiddenInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
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

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type SegmentProps = ArkPartProps<'span'>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type SegmentGroupProps = PartProps<'div', Api['getSegmentGroupProps']>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;

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
