import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useMenu } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useMenu;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const menuItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
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
		},
		props,
	);
	{
		children;
	}
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	{
		children;
	}
}
export function ArrowTip(props: ArrowTipProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function RadioItem(props: RadioItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getOptionItemProps',
			propKeys: [
				'closeOnSelect',
				'disabled',
				'value',
				'valueText',
			],
			provideProps: menuItemProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function TriggerItem(props: TriggerItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, provideProps: menuItemProps }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Item(props: ItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'closeOnSelect',
				'disabled',
				'value',
				'valueText',
				'onSelect',
			],
			provideProps: menuItemProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroup(props: ItemGroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemGroupProps',
			propKeys: [
				'id',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Indicator(props: IndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function RadioItemGroup(props: RadioItemGroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemGroupProps',
			propKeys: [
				'id',
				'onValueChange',
				'value',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Arrow(props: ArrowProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: menuItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getItemGroupLabelProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ContextTrigger(props: ContextTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getContextTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Separator(props: SeparatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getSeparatorProps' }, props);
	<hr {...mergedProps.value} />
}
export function ItemText(props: ItemTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: menuItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function CheckboxItem(props: CheckboxItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
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
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, menuItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ComponentProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ComponentProps & { value: ReturnType<Hook> };
export type ArrowTipProps = PartProps<'div', Api['getArrowTipProps']>;
export type RadioItemProps = PartProps<'div', Api['getOptionItemProps']>;
export type TriggerItemProps = ArkPartProps<'div'>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type ItemGroupProps = PartProps<'div', Api['getItemGroupProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;
export type RadioItemGroupProps = PartProps<'div', Api['getItemGroupProps']>;
export type ArrowProps = PartProps<'div', Api['getArrowProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ItemIndicatorProps = ArkPartProps<'div'>;
export type ItemGroupLabelProps = PartProps<'div', Api['getItemGroupLabelProps']>;
export type ContextTriggerProps = PartProps<'button', Api['getContextTriggerProps']>;
export type SeparatorProps = PartProps<'hr', Api['getSeparatorProps']>;
export type ItemTextProps = ArkPartProps<'div'>;
export type CheckboxItemProps = PartProps<'div', Api['getOptionItemProps']>;

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
