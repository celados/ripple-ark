import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

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
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<div {...mergedProps.value}>{children}</div>
}
export function WeekNumberCell(props: WeekNumberCellProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getWeekNumberCellProps' }, props);
	<td {...mergedProps.value}>{children}</td>
}
export function TableHead(props: TableHeadProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableHeadProps' }, props);
	<thead {...mergedProps.value}>{children}</thead>
}
export function TableRow(props: TableRowProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableRowProps' }, props);
	<tr {...mergedProps.value}>{children}</tr>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function ViewControl(props: ViewControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ViewTrigger(props: ViewTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
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
	<td {...mergedProps.value}>{children}</td>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
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
export function WeekNumberHeaderCell(props: WeekNumberHeaderCellProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getWeekNumberHeaderCellProps' }, props);
	<th {...mergedProps.value}>{children}</th>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function TableCellTrigger(props: TableCellTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getClearTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function TableHeader(props: TableHeaderProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableHeaderProps' }, props);
	<th {...mergedProps.value}>{children}</th>
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getNextTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function MonthSelect(props: MonthSelectProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getMonthSelectProps' }, props);
	<select {...mergedProps.value}>{children}</select>
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
	<button {...mergedProps.value}>{children}</button>
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
	<table {...mergedProps.value}>{children}</table>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPrevTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
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
	<input {...mergedProps.value} />
}
export function YearSelect(props: YearSelectProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getYearSelectProps' }, props);
	<select {...mergedProps.value}>{children}</select>
}
export function RangeText(props: RangeTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getRangeTextProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function TableBody(props: TableBodyProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTableBodyProps' }, props);
	<tbody {...mergedProps.value}>{children}</tbody>
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
export type WeekNumberCellProps = PartProps<'td', Api['getWeekNumberCellProps']>;
export type TableHeadProps = PartProps<'thead', Api['getTableHeadProps']>;
export type TableRowProps = PartProps<'tr', Api['getTableRowProps']>;
export type ValueTextProps = ArkPartProps<'span'>;
export type ViewControlProps = PartProps<'div', Api['getViewControlProps']>;
export type ViewTriggerProps = PartProps<'button', Api['getViewTriggerProps']>;
export type TableCellProps = ArkPartProps<'td'>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type WeekNumberHeaderCellProps = PartProps<'th', Api['getWeekNumberHeaderCellProps']>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type TableCellTriggerProps = ArkPartProps<'div'>;
export type ClearTriggerProps = PartProps<'button', Api['getClearTriggerProps']>;
export type TableHeaderProps = PartProps<'th', Api['getTableHeaderProps']>;
export type NextTriggerProps = PartProps<'button', Api['getNextTriggerProps']>;
export type MonthSelectProps = PartProps<'select', Api['getMonthSelectProps']>;
export type PresetTriggerProps = PartProps<'button', Api['getPresetTriggerProps']>;
export type TableProps = PartProps<'table', Api['getTableProps']>;
export type PrevTriggerProps = PartProps<'button', Api['getPrevTriggerProps']>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type YearSelectProps = PartProps<'select', Api['getYearSelectProps']>;
export type RangeTextProps = PartProps<'div', Api['getRangeTextProps']>;
export type TableBodyProps = PartProps<'tbody', Api['getTableBodyProps']>;
export type ViewProps = ArkPartProps<'div'>;

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
