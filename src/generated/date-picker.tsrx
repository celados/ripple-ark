import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDatePicker } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function WeekNumberCell(props: WeekNumberCellProps) @{
	let &{ children } = props;
	<Part
		tag="td"
		options={{ context, getter: 'getWeekNumberCellProps' }}
		of={props}
	>{children}</Part>
}
export function TableHead(props: TableHeadProps) @{
	let &{ children } = props;
	<Part tag="thead" options={{ context, getter: 'getTableHeadProps' }} of={props}>{children}</Part>
}
export function TableRow(props: TableRowProps) @{
	let &{ children } = props;
	<Part tag="tr" options={{ context, getter: 'getTableRowProps' }} of={props}>{children}</Part>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context }} of={props}>{children}</Part>
}
export function ViewControl(props: ViewControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getViewControlProps' }} of={props}>{children}</Part>
}
export function ViewTrigger(props: ViewTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getViewTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function TableCell(props: TableCellProps) @{
	let &{ children } = props;
	<Part
		tag="td"
		options={{
			context,
			propKeys: [
				'disabled',
				'value',
				'visibleRange',
				'columns',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
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
export function WeekNumberHeaderCell(props: WeekNumberHeaderCellProps) @{
	let &{ children } = props;
	<Part
		tag="th"
		options={{ context, getter: 'getWeekNumberHeaderCellProps' }}
		of={props}
	>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part tag="button" options={{ context, getter: 'getTriggerProps' }} of={props}>{children}</Part>
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
export function TableCellTrigger(props: TableCellTriggerProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context }} of={props}>{children}</Part>
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getClearTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function TableHeader(props: TableHeaderProps) @{
	let &{ children } = props;
	<Part tag="th" options={{ context, getter: 'getTableHeaderProps' }} of={props}>{children}</Part>
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getNextTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function MonthSelect(props: MonthSelectProps) @{
	let &{ children } = props;
	<Part
		tag="select"
		options={{ context, getter: 'getMonthSelectProps' }}
		of={props}
	>{children}</Part>
}
export function PresetTrigger(props: PresetTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getPresetTriggerProps',
			propKeys: [
				'value',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Table(props: TableProps) @{
	let &{ children } = props;
	<Part
		tag="table"
		options={{
			context,
			getter: 'getTableProps',
			propKeys: [
				'columns',
			],
		}}
		of={props}
	>{children}</Part>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getPrevTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part
		tag="input"
		options={{
			context,
			getter: 'getInputProps',
			propKeys: [
				'index',
				'fixOnBlur',
			],
		}}
		of={props}
	/>
}
export function YearSelect(props: YearSelectProps) @{
	let &{ children } = props;
	<Part
		tag="select"
		options={{ context, getter: 'getYearSelectProps' }}
		of={props}
	>{children}</Part>
}
export function RangeText(props: RangeTextProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getRangeTextProps' }} of={props}>{children}</Part>
}
export function TableBody(props: TableBodyProps) @{
	let &{ children } = props;
	<Part tag="tbody" options={{ context, getter: 'getTableBodyProps' }} of={props}>{children}</Part>
}
export function View(props: ViewProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			propKeys: [
				'view',
			],
		}}
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
