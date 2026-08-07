import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCombobox } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useCombobox;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const comboboxItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const comboboxItemGroupProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [],

	useMachine: useCombobox as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const List = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getListProps',
});
export const Input = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
});
export const ItemText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: comboboxItemProps,
});
export const ClearTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const ItemGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
	provideProps: comboboxItemGroupProps,
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'item',
		'persistFocus',
	],
	provideProps: comboboxItemProps,
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'focusable',
	],
});
export const Empty = /*#__PURE__*/ createPart({ context, defaultTag: 'div' });
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const ItemIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: comboboxItemProps,
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const ItemGroupLabel = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupLabelProps',
	inheritedProps: comboboxItemGroupProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, comboboxItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ListProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type ClearTriggerProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type ItemGroupProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type EmptyProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type ItemIndicatorProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type ItemGroupLabelProps = ArkPartProps;

export const Combobox = {
	Root,
	RootProvider,
	List,
	Input,
	ItemText,
	ClearTrigger,
	Positioner,
	ItemGroup,
	Item,
	Content,
	Trigger,
	Empty,
	Label,
	ItemIndicator,
	Control,
	ItemGroupLabel,
	ItemContext,
	Context,
};
