import {
	Context as RippleContext,
	effect,
	track,
	createRefKey,
	type Children,
	type Tracked,
} from 'ripple';

import { useDatePicker } from '../components';
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
	createRenderContent,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
	type PresenceState,
} from '../binding-runtime.tsrx';

type Hook = typeof useDatePicker;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'closeOnSelect',
				'createCalendar',
				'defaultFocusedValue',
				'defaultOpen',
				'defaultValue',
				'defaultView',
				'disabled',
				'fixedWeeks',
				'focusedValue',
				'format',
				'id',
				'ids',
				'inline',
				'invalid',
				'isDateUnavailable',
				'locale',
				'max',
				'maxSelectedDates',
				'maxView',
				'min',
				'minView',
				'name',
				'numOfMonths',
				'onFocusChange',
				'onOpenChange',
				'onValueChange',
				'onViewChange',
				'onVisibleRangeChange',
				'open',
				'openOnClick',
				'outsideDaySelectable',
				'parse',
				'placeholder',
				'positioning',
				'readOnly',
				'required',
				'selectionMode',
				'showWeekNumbers',
				'startOfWeek',
				'timeZone',
				'translations',
				'value',
				'view',
			],
			omitKeys: PRESENCE_KEYS,

			useMachine: useDatePicker as any,
		},
		props,
	);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function WeekNumberCell(props: WeekNumberCellProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getWeekNumberCellProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<td {...mergedProps.value}>{children}</td>
	}
}
export function TableHead(props: TableHeadProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableHeadProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<thead {...mergedProps.value}>{children}</thead>
	}
}
export function TableRow(props: TableRowProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableRowProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<tr {...mergedProps.value}>{children}</tr>
	}
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
}
export function ViewControl(props: ViewControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewControlProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ViewTrigger(props: ViewTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function TableCell(props: TableCellProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			propKeys: [
				'disabled',
				'value',
				'visibleRange',
				'columns',
			],
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<td {...mergedProps.value}>{children}</td>
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
export function Content(props: ContentProps) @{
	let &{ children, ref } = props;
	const presence = usePresenceState(presenceContext);
	const presenceRefKey = createRefKey();
	let applyPresenceRef = (node: any) => {
		presence.value.setNode(node);
		if (typeof ref === 'function') ref(node);
	};
	const mergedProps = usePartProps(
		{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] },
		props,
	);
	@if (!presence.value.unmounted) {
		@if (props.render) {
			const Content = createRenderContent(
				track(() => ({ ...mergedProps.value, [presenceRefKey]: applyPresenceRef })),
				props.render,
			);
			<{Content} />
		} @else {
			<div {...mergedProps.value} ref={applyPresenceRef}>{children}</div>
		}
	}
}
export function WeekNumberHeaderCell(props: WeekNumberHeaderCellProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getWeekNumberHeaderCellProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<th {...mergedProps.value}>{children}</th>
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
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		@if (props.render) {
			const Content = createRenderContent(mergedProps, props.render);
			<{Content} />
		} @else {
			<div {...mergedProps.value}>{children}</div>
		}
	}
}
export function TableCellTrigger(props: TableCellTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getClearTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function TableHeader(props: TableHeaderProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableHeaderProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<th {...mergedProps.value}>{children}</th>
	}
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getNextTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function MonthSelect(props: MonthSelectProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getMonthSelectProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<select {...mergedProps.value}>{children}</select>
	}
}
export function PresetTrigger(props: PresetTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getPresetTriggerProps',
			propKeys: [
				'value',
			],
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Table(props: TableProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTableProps',
			propKeys: [
				'columns',
			],
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<table {...mergedProps.value}>{children}</table>
	}
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPrevTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Input(props: InputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getInputProps',
			propKeys: [
				'index',
				'fixOnBlur',
			],
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<input {...mergedProps.value} />
	}
}
export function YearSelect(props: YearSelectProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getYearSelectProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<select {...mergedProps.value}>{children}</select>
	}
}
export function RangeText(props: RangeTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getRangeTextProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function TableBody(props: TableBodyProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableBodyProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<tbody {...mergedProps.value}>{children}</tbody>
	}
}
export function View(props: ViewProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			propKeys: [
				'view',
			],
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
export type WeekNumberCellProps =
	(PartProps<'td', Api['getWeekNumberCellProps']>) & { render?: RenderProp<'td'> };
export type TableHeadProps =
	(PartProps<'thead', Api['getTableHeadProps']>) & { render?: RenderProp<'thead'> };
export type TableRowProps =
	(PartProps<'tr', Api['getTableRowProps']>) & { render?: RenderProp<'tr'> };
export type ValueTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type ViewControlProps =
	(PartProps<'div', Api['getViewControlProps']>) & { render?: RenderProp<'div'> };
export type ViewTriggerProps =
	(PartProps<'button', Api['getViewTriggerProps']>) & { render?: RenderProp<'button'> };
export type TableCellProps = (ArkPartProps<'td'>) & { render?: RenderProp<'td'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type WeekNumberHeaderCellProps =
	(PartProps<'th', Api['getWeekNumberHeaderCellProps']>) & { render?: RenderProp<'th'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type TableCellTriggerProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ClearTriggerProps =
	(PartProps<'button', Api['getClearTriggerProps']>) & { render?: RenderProp<'button'> };
export type TableHeaderProps =
	(PartProps<'th', Api['getTableHeaderProps']>) & { render?: RenderProp<'th'> };
export type NextTriggerProps =
	(PartProps<'button', Api['getNextTriggerProps']>) & { render?: RenderProp<'button'> };
export type MonthSelectProps =
	(PartProps<'select', Api['getMonthSelectProps']>) & { render?: RenderProp<'select'> };
export type PresetTriggerProps =
	(PartProps<'button', Api['getPresetTriggerProps']>) & { render?: RenderProp<'button'> };
export type TableProps =
	(PartProps<'table', Api['getTableProps']>) & { render?: RenderProp<'table'> };
export type PrevTriggerProps =
	(PartProps<'button', Api['getPrevTriggerProps']>) & { render?: RenderProp<'button'> };
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };
export type YearSelectProps =
	(PartProps<'select', Api['getYearSelectProps']>) & { render?: RenderProp<'select'> };
export type RangeTextProps =
	(PartProps<'div', Api['getRangeTextProps']>) & { render?: RenderProp<'div'> };
export type TableBodyProps =
	(PartProps<'tbody', Api['getTableBodyProps']>) & { render?: RenderProp<'tbody'> };
export type ViewProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };

export const DatePicker = {
	Root,
	RootProvider,
	WeekNumberCell,
	TableHead,
	TableRow,
	ValueText,
	ViewControl,
	ViewTrigger,
	TableCell,
	Control,
	Content,
	WeekNumberHeaderCell,
	Label,
	Trigger,
	Positioner,
	TableCellTrigger,
	ClearTrigger,
	TableHeader,
	NextTrigger,
	MonthSelect,
	PresetTrigger,
	Table,
	PrevTrigger,
	Input,
	YearSelect,
	RangeText,
	TableBody,
	View,
	Context,
};
