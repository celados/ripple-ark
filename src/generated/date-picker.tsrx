import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDatePicker } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useDatePicker;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
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

	useMachine: useDatePicker as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const WeekNumberCell = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'td',
	getter: 'getWeekNumberCellProps',
});
export const TableHead = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'thead',
	getter: 'getTableHeadProps',
});
export const TableRow = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'tr',
	getter: 'getTableRowProps',
});
export const ValueText = /*#__PURE__*/ createPart({ context, defaultTag: 'span' });
export const ViewControl = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewControlProps',
});
export const ViewTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getViewTriggerProps',
});
export const TableCell = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'td',
	propKeys: [
		'disabled',
		'value',
		'visibleRange',
		'columns',
	],
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const WeekNumberHeaderCell = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'th',
	getter: 'getWeekNumberHeaderCellProps',
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
});
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const TableCellTrigger = /*#__PURE__*/ createPart({ context, defaultTag: 'div' });
export const ClearTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const TableHeader = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'th',
	getter: 'getTableHeaderProps',
});
export const NextTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getNextTriggerProps',
});
export const MonthSelect = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'select',
	getter: 'getMonthSelectProps',
});
export const PresetTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getPresetTriggerProps',
	propKeys: [
		'value',
	],
});
export const Table = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'table',
	getter: 'getTableProps',
});
export const PrevTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getPrevTriggerProps',
});
export const Input = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
	propKeys: [
		'index',
		'fixOnBlur',
	],
});
export const YearSelect = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'select',
	getter: 'getYearSelectProps',
});
export const RangeText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getRangeTextProps',
});
export const TableBody = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'tbody',
	getter: 'getTableBodyProps',
});
export const View = /*#__PURE__*/ createPart({ context, defaultTag: 'div' });

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type WeekNumberCellProps = ArkPartProps;
export type TableHeadProps = ArkPartProps;
export type TableRowProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type ViewControlProps = ArkPartProps;
export type ViewTriggerProps = ArkPartProps;
export type TableCellProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type WeekNumberHeaderCellProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type TableCellTriggerProps = ArkPartProps;
export type ClearTriggerProps = ArkPartProps;
export type TableHeaderProps = ArkPartProps;
export type NextTriggerProps = ArkPartProps;
export type MonthSelectProps = ArkPartProps;
export type PresetTriggerProps = ArkPartProps;
export type TableProps = ArkPartProps;
export type PrevTriggerProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type YearSelectProps = ArkPartProps;
export type RangeTextProps = ArkPartProps;
export type TableBodyProps = ArkPartProps;
export type ViewProps = ArkPartProps;

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
