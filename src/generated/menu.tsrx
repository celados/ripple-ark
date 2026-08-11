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
	Part,
	createApiContext,
	createItemContext,
	usePartProps,
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
	<Part tag="div" options={{ context, getter: 'getArrowTipProps' }} of={props}>{children}</Part>
}
export function RadioItem(props: RadioItemProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getOptionItemProps',
			propKeys: [
				'closeOnSelect',
				'disabled',
				'value',
				'valueText',
			],
			provideProps: menuItemProps,
		}}
		of={props}
	>{children}</Part>
}
export function TriggerItem(props: TriggerItemProps) @{
	let &{ children, render: _render, ...localProps } = props;
	const triggerProps = menuTriggerItemProps.get();
	const mergedProps = track(() => mergeProps(triggerProps?.value ?? {}, localProps));
	menuItemProps.set(track(() => ({ value: mergedProps.value['data-value'] })));
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
			presence: presenceContext,
			presenceProps: (state) => ({ 'aria-controls': state.unmounted && null }),
		}}
		of={props}
	>{children}</Part>
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
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
export function ItemGroup(props: ItemGroupProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getItemGroupProps',
			propKeys: [
				'id',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getIndicatorProps' }} of={props}>{children}</Part>
}
export function RadioItemGroup(props: RadioItemGroupProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getItemGroupProps',
			propKeys: [
				'id',
				'onValueChange',
				'value',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowProps' }} of={props}>{children}</Part>
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
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemIndicatorProps', inheritedProps: menuItemProps }}
		of={props}
	>{children}</Part>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemGroupLabelProps' }}
		of={props}
	>{children}</Part>
}
export function ContextTrigger(props: ContextTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getContextTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Separator(props: SeparatorProps) @{
	<Part tag="hr" options={{ context, getter: 'getSeparatorProps' }} of={props} />
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemTextProps', inheritedProps: menuItemProps }}
		of={props}
	>{children}</Part>
}
export function CheckboxItem(props: CheckboxItemProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
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
		}}
		of={props}
	>{children}</Part>
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
export type ArrowTipProps =
	(PartProps<'div', Api['getArrowTipProps']>) & { render?: RenderProp<'div'> };
export type RadioItemProps =
	(PartProps<'div', Api['getOptionItemProps']>) & { render?: RenderProp<'div'> };
export type TriggerItemProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type ItemGroupProps =
	(PartProps<'div', Api['getItemGroupProps']>) & { render?: RenderProp<'div'> };
export type IndicatorProps =
	(PartProps<'div', Api['getIndicatorProps']>) & { render?: RenderProp<'div'> };
export type RadioItemGroupProps =
	(PartProps<'div', Api['getItemGroupProps']>) & { render?: RenderProp<'div'> };
export type ArrowProps = (PartProps<'div', Api['getArrowProps']>) & { render?: RenderProp<'div'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type ItemIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemGroupLabelProps =
	(PartProps<'div', Api['getItemGroupLabelProps']>) & { render?: RenderProp<'div'> };
export type ContextTriggerProps =
	(PartProps<'button', Api['getContextTriggerProps']>) & { render?: RenderProp<'button'> };
export type SeparatorProps =
	(PartProps<'hr', Api['getSeparatorProps']>) & { render?: RenderProp<'hr'> };
export type ItemTextProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type CheckboxItemProps =
	(PartProps<'div', Api['getOptionItemProps']>) & { render?: RenderProp<'div'> };

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
