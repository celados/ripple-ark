import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSelect } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useSelect;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const selectItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const selectItemGroupProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [],

	useMachine: useSelect as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const List = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getListProps',
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
});
export const ItemIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: selectItemProps,
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const HiddenSelect = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'select',
	getter: 'getHiddenSelectProps',
});
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const ClearTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const ItemText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: selectItemProps,
});
export const ItemGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
	provideProps: selectItemGroupProps,
});
export const ItemGroupLabel = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupLabelProps',
	inheritedProps: selectItemGroupProps,
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'item',
		'persistFocus',
	],
	provideProps: selectItemProps,
});
export const ValueText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getValueTextProps',
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, selectItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ListProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ItemIndicatorProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type HiddenSelectProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type ClearTriggerProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type ItemGroupProps = ArkPartProps;
export type ItemGroupLabelProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type LabelProps = ArkPartProps;

export const Select = {
	Root,
	RootProvider,
	List,
	Trigger,
	ItemIndicator,
	Indicator,
	Content,
	HiddenSelect,
	Positioner,
	ClearTrigger,
	Control,
	ItemText,
	ItemGroup,
	ItemGroupLabel,
	Item,
	ValueText,
	Label,
	ItemContext,
	Context,
};
