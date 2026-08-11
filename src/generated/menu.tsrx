import {
	Context as RippleContext,
	effect,
	track,
	untrack,
	type Children,
	type Tracked,
} from 'ripple';
import { mergeProps } from '@zag-js/core';
import { useMenu } from '../components';
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

type Hook = typeof useMenu;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);
const menuTriggerItemProps = /*#__PURE__*/ new RippleContext<Tracked<AnyRecord> | null>(null);
const menuItemProps = /*#__PURE__*/ new RippleContext<Tracked<Record<string, any>> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const parentApi = context.get();
	useRootProps(
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
			omitKeys: PRESENCE_KEYS,
			useMachine: useMenu as any,
		},
		props,
	);
	const api = context.get()!;
	const childService = (api as any).service;
	useRootPresence(presenceContext, () => api.value.open, props);
	if (parentApi) {
		effect(() => {
			untrack(() => {
				(parentApi as any).value.setChild(childService);
				api.value.setParent((parentApi as any).service);
			});
		});
		menuTriggerItemProps.set(track(() => (parentApi as any).value.getTriggerItemProps(api.value)));
	}
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const parentApi = context.get();
	useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	const childService = props.value.service;
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	if (parentApi) {
		effect(() => {
			untrack(() => {
				(parentApi as any).value.setChild(childService);
				props.value.value.setParent((parentApi as any).service);
			});
		});
		menuTriggerItemProps.set(
			track(() => (parentApi as any).value.getTriggerItemProps(props.value.value)),
		);
	}
	<>
		{children}
	</>
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function RadioItem(props: RadioItemProps) @{
	let &{ children } = props;
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
	let &{ children, ...localProps } = props;
	const triggerProps = menuTriggerItemProps.get();
	const mergedProps = track(() => mergeProps(triggerProps?.value ?? {}, localProps));
	menuItemProps.set(track(() => ({ value: mergedProps.value['data-value'] })));
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
			presence: presenceContext,
			presenceProps: (state) => ({ 'aria-controls': state.unmounted && null }),
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const api = context.get();
	if (!api) throw new Error('Menu.Item must be rendered inside Menu.Root or RootProvider');
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
	const itemProps = menuItemProps.get()!;
	effect(() => {
		const onSelect = itemProps.value.onSelect;
		if (!onSelect) return;
		return api.value.addItemListener({
			id: api.value.getItemState(itemProps.value as any).id,
			onSelect,
		});
	});
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
export function ItemGroup(props: ItemGroupProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function RadioItemGroup(props: RadioItemGroupProps) @{
	let &{ children } = props;
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
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: menuItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getItemGroupLabelProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ContextTrigger(props: ContextTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContextTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Separator(props: SeparatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSeparatorProps' }, props);
	<hr {...mergedProps.value} />
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: menuItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function CheckboxItem(props: CheckboxItemProps) @{
	let &{ children } = props;
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

export type RootProps =
	ComponentProps & NonNullable<Parameters<Hook>[0]> & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type RootProviderProps =
	ComponentProps & { value: ReturnType<Hook> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
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
