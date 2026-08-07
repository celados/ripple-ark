import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDatePicker } from '../components.ts';
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

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
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
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const WeekNumberCell = createPart({
	context,
	defaultTag: 'td',
	getter: 'getWeekNumberCellProps',
});
export const TableHead = createPart({ context, defaultTag: 'thead', getter: 'getTableHeadProps' });
export const TableRow = createPart({ context, defaultTag: 'tr', getter: 'getTableRowProps' });
export const ValueText = createPart({ context, defaultTag: 'span' });
export const ViewControl = createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewControlProps',
});
export const ViewTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getViewTriggerProps',
});
export const TableCell = createPart({
	context,
	defaultTag: 'td',
	propKeys: [
		'disabled',
		'value',
		'visibleRange',
		'columns',
	],
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const WeekNumberHeaderCell = createPart({
	context,
	defaultTag: 'th',
	getter: 'getWeekNumberHeaderCellProps',
});
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const Trigger = createPart({ context, defaultTag: 'button', getter: 'getTriggerProps' });
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const TableCellTrigger = createPart({ context, defaultTag: 'div' });
export const ClearTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const TableHeader = createPart({ context, defaultTag: 'th', getter: 'getTableHeaderProps' });
export const NextTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getNextTriggerProps',
});
export const MonthSelect = createPart({
	context,
	defaultTag: 'select',
	getter: 'getMonthSelectProps',
});
export const PresetTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getPresetTriggerProps',
	propKeys: [
		'value',
	],
});
export const Table = createPart({ context, defaultTag: 'table', getter: 'getTableProps' });
export const PrevTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getPrevTriggerProps',
});
export const Input = createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
	propKeys: [
		'index',
		'fixOnBlur',
	],
});
export const YearSelect = createPart({
	context,
	defaultTag: 'select',
	getter: 'getYearSelectProps',
});
export const RangeText = createPart({ context, defaultTag: 'div', getter: 'getRangeTextProps' });
export const TableBody = createPart({ context, defaultTag: 'tbody', getter: 'getTableBodyProps' });
export const View = createPart({ context, defaultTag: 'div' });

export const Context = createApiContext(context);

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
