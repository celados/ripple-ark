import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDateInput } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useDateInput;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const dateInputSegmentGroupProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
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
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Segment = createPart({
	context,
	defaultTag: 'span',
	getter: 'getSegmentProps',
	inheritedProps: dateInputSegmentGroupProps,
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const SegmentGroup = createPart({
	context,
	defaultTag: 'div',
	getter: 'getSegmentGroupProps',
	provideProps: dateInputSegmentGroupProps,
});
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const HiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});

export function SegmentContext(props: { children: (segment: AnyRecord) => Children }) @{
	const api = context.get();
	const groupProps = dateInputSegmentGroupProps.get();
	if (
		!api || !groupProps
	) throw new Error('DateInput.SegmentContext must be rendered inside SegmentGroup');
	const segments = track(() => api.value.getSegments(groupProps));
	const render = props.children;
	@for (const segment of segments.value; index index) {
		<>
			{render({ ...segment, index })}
		</>
	}
}
export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type SegmentProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type SegmentGroupProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;

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
