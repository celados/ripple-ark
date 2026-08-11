import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSelect } from '../components';
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

type Hook = typeof useSelect;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

const selectItemProps = /*#__PURE__*/ new RippleContext<Tracked<Record<string, any>> | null>(null);
const selectItemGroupProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'autoComplete',
				'closeOnSelect',
				'collection',
				'composite',
				'defaultHighlightedValue',
				'defaultOpen',
				'defaultValue',
				'deselectable',
				'disabled',
				'form',
				'highlightedValue',
				'id',
				'ids',
				'invalid',
				'loopFocus',
				'multiple',
				'name',
				'onFocusOutside',
				'onHighlightChange',
				'onInteractOutside',
				'onOpenChange',
				'onPointerDownOutside',
				'onSelect',
				'onValueChange',
				'open',
				'positioning',
				'readOnly',
				'required',
				'scrollToIndexFn',
				'translations',
				'value',
			],
			omitKeys: PRESENCE_KEYS,

			useMachine: useSelect as any,
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
export function List(props: ListProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getListProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: selectItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
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
export function HiddenSelect(props: HiddenSelectProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHiddenSelectProps' }, props);
	<select {...mergedProps.value}>{children}</select>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getClearTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: selectItemProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
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
			provideProps: selectItemGroupProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemGroupLabelProps', inheritedProps: selectItemGroupProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'item',
				'persistFocus',
			],
			provideProps: selectItemProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ValueText(props: ValueTextProps) @{
	const api = context.get()!;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getValueTextProps',
			propKeys: [
				'placeholder',
			],
		},
		props,
	);
	<span {...mergedProps.value}>{api.value.valueAsString || (props as any).placeholder}</span>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, selectItemProps);

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
export type ListProps = PartProps<'div', Api['getListProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ItemIndicatorProps = ArkPartProps<'div'>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type HiddenSelectProps = PartProps<'select', Api['getHiddenSelectProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ClearTriggerProps = PartProps<'button', Api['getClearTriggerProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type ItemTextProps = ArkPartProps<'span'>;
export type ItemGroupProps = PartProps<'div', Api['getItemGroupProps']>;
export type ItemGroupLabelProps = ArkPartProps<'div'>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ValueTextProps = PartProps<'span', Api['getValueTextProps']> & { placeholder?: string };
export type LabelProps = PartProps<'label', Api['getLabelProps']>;

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
