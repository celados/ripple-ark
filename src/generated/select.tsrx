import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { mergeProps } from '@zag-js/core';
import { useSelect } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	createPartId,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	PRESENCE_KEYS,
	splitProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
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
	useRootPresence(
		presenceContext,
		() => (props as AnyRecord).present === undefined
			? context.get()!.value.open
			: Boolean((props as AnyRecord).present),
		props,
	);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(
		presenceContext,
		() => (props as AnyRecord).present === undefined
			? context.get()!.value.open
			: Boolean((props as AnyRecord).present),
		props,
	);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function List(props: ListProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getListProps' }} of={props}>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part tag="button" options={{ context, getter: 'getTriggerProps' }} of={props}>{children}</Part>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemIndicatorProps', inheritedProps: selectItemProps }}
		of={props}
	>{children}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getIndicatorProps' }} of={props}>{children}</Part>
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
export function HiddenSelect(props: HiddenSelectProps) @{
	const api = context.get();
	if (
		!api
	) throw new Error('Select.HiddenSelect must be rendered inside Select.Root or RootProvider');
	<Part tag="select" options={{ context, getter: 'getHiddenSelectProps' }} of={props}>
		@if (api.value.value.length === 0) {
			<option value="" />
		}
		@for (const item of api.value.collection.items) {
			<option
				value={api.value.collection.getItemValue(item) ?? ''}
				disabled={api.value.collection.getItemDisabled(item)}
			>{api.value.collection.stringifyItem(item)}</option>
		}
	</Part>
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
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getClearTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getItemTextProps', inheritedProps: selectItemProps }}
		of={props}
	>{children}</Part>
}
export function ItemGroup(props: ItemGroupProps) @{
	let &{ children } = props;
	const autoId = createPartId('select-group');
	<Part
		tag="div"
		options={{
			context,
			getter: 'getItemGroupProps',
			propKeys: ['id'],
			propDefaults: { id: () => autoId },
			provideProps: selectItemGroupProps,
		}}
		of={props}
	>{children}</Part>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	let &{ children } = props;
	const api = context.get();
	const group = selectItemGroupProps.get();
	if (
		!api || !group
	) throw new Error('Select.ItemGroupLabel must be rendered inside Select.ItemGroup');
	const mergedProps = track(
		() => mergeProps(
			api.value.getItemGroupLabelProps({ htmlFor: group.value.id }),
			splitProps(props, [])[1],
		),
	);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getItemProps',
			propKeys: [
				'item',
				'persistFocus',
			],
			provideProps: selectItemProps,
		}}
		of={props}
	>{children}</Part>
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
	<Part tag="span" merged={mergedProps} of={props}>
		{api.value.valueAsString || (props as any).placeholder}
	</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
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
export type ListProps = (PartProps<'div', Api['getListProps']>) & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ItemIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type IndicatorProps =
	(PartProps<'div', Api['getIndicatorProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type HiddenSelectProps =
	(PartProps<'select', Api['getHiddenSelectProps']>) & { render?: RenderProp<'select'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type ClearTriggerProps =
	(PartProps<'button', Api['getClearTriggerProps']>) & { render?: RenderProp<'button'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type ItemTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type ItemGroupProps =
	(ArkPartProps<'div'> & { id?: string }) & { render?: RenderProp<'div'> };
export type ItemGroupLabelProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ValueTextProps =
	(PartProps<'span', Api['getValueTextProps']> & { placeholder?: string }) & {
		render?: RenderProp<'span'>;
	};
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };

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
