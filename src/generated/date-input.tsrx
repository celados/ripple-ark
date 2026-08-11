import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDateInput } from '../components';
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
export function Segment(props: SegmentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getSegmentProps', inheritedProps: dateInputSegmentGroupProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
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
export function SegmentGroup(props: SegmentGroupProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getSegmentGroupProps', provideProps: dateInputSegmentGroupProps },
		props,
	);
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
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<input {...mergedProps.value} />
	}
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
