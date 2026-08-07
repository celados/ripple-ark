import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useMenu } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useMenu;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const menuItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	configKeys: [
		'anchorPoint',
		'aria-label',
		'closeOnSelect',
		'composite',
		'defaultHighlightedValue',
		'defaultOpen',
		'highlightedValue',
		'id',
		'ids',
		'loopFocus',
		'navigate',
		'onEscapeKeyDown',
		'onFocusOutside',
		'onHighlightChange',
		'onInteractOutside',
		'onOpenChange',
		'onPointerDownOutside',
		'onRequestDismiss',
		'onSelect',
		'open',
		'positioning',
		'typeahead',
		'triggerValue',
		'defaultTriggerValue',
		'onTriggerValueChange',
	],

	useMachine: useMenu as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context });
export const ArrowTip = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowTipProps',
});
export const RadioItem = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getOptionItemProps',
	propKeys: [
		'closeOnSelect',
		'disabled',
		'value',
		'valueText',
	],
	provideProps: menuItemProps,
});
export const TriggerItem = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	provideProps: menuItemProps,
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	propKeys: [
		'value',
	],
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'closeOnSelect',
		'disabled',
		'value',
		'valueText',
		'onSelect',
	],
	provideProps: menuItemProps,
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const ItemGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
	propKeys: [
		'id',
	],
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
});
export const RadioItemGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
	propKeys: [
		'id',
		'onValueChange',
		'value',
	],
});
export const Arrow = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowProps',
});
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const ItemIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: menuItemProps,
});
export const ItemGroupLabel = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupLabelProps',
});
export const ContextTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getContextTriggerProps',
});
export const Separator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'hr',
	getter: 'getSeparatorProps',
});
export const ItemText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemTextProps',
	inheritedProps: menuItemProps,
});
export const CheckboxItem = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getOptionItemProps',
	propKeys: [
		'checked',
		'closeOnSelect',
		'disabled',
		'onCheckedChange',
		'value',
		'valueText',
	],
	provideProps: menuItemProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, menuItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ArrowTipProps = ArkPartProps;
export type RadioItemProps = ArkPartProps;
export type TriggerItemProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type ItemGroupProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type RadioItemGroupProps = ArkPartProps;
export type ArrowProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type ItemIndicatorProps = ArkPartProps;
export type ItemGroupLabelProps = ArkPartProps;
export type ContextTriggerProps = ArkPartProps;
export type SeparatorProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type CheckboxItemProps = ArkPartProps;

export const Menu = {
	Root,
	RootProvider,
	ArrowTip,
	RadioItem,
	TriggerItem,
	Trigger,
	Item,
	Content,
	ItemGroup,
	Indicator,
	RadioItemGroup,
	Arrow,
	Positioner,
	ItemIndicator,
	ItemGroupLabel,
	ContextTrigger,
	Separator,
	ItemText,
	CheckboxItem,
	ItemContext,
	Context,
};
