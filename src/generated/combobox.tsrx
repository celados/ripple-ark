import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCombobox } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
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

type Hook = typeof useCombobox;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

const comboboxItemProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);
const comboboxItemGroupProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'allowCustomValue',
				'alwaysSubmitOnEnter',
				'autoFocus',
				'closeOnSelect',
				'collection',
				'composite',
				'defaultHighlightedValue',
				'defaultInputValue',
				'defaultOpen',
				'defaultValue',
				'disabled',
				'disableLayer',
				'form',
				'highlightedValue',
				'id',
				'ids',
				'inputBehavior',
				'inputValue',
				'invalid',
				'loopFocus',
				'multiple',
				'name',
				'navigate',
				'onFocusOutside',
				'onHighlightChange',
				'onInputValueChange',
				'onInteractOutside',
				'onOpenChange',
				'onPointerDownOutside',
				'onValueChange',
				'onSelect',
				'open',
				'openOnChange',
				'openOnClick',
				'openOnKeyPress',
				'placeholder',
				'positioning',
				'readOnly',
				'required',
				'scrollToIndexFn',
				'selectionBehavior',
				'translations',
				'value',
			],
			omitKeys: PRESENCE_KEYS,

			useMachine: useCombobox as any,
		},
		props,
	);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function List(props: ListProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getListProps' }} of={props}>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part tag="input" options={{ context, getter: 'getInputProps' }} of={props} />
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getItemTextProps', inheritedProps: comboboxItemProps }}
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
			provideProps: comboboxItemGroupProps,
		}}
		of={props}
	>{children}</Part>
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
			provideProps: comboboxItemProps,
		}}
		of={props}
	>{children}</Part>
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
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'focusable',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Empty(props: EmptyProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context }} of={props}>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemIndicatorProps', inheritedProps: comboboxItemProps }}
		of={props}
	>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemGroupLabelProps', inheritedProps: comboboxItemGroupProps }}
		of={props}
	>{children}</Part>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, comboboxItemProps);

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
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };
export type ItemTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type ClearTriggerProps =
	(PartProps<'button', Api['getClearTriggerProps']>) & { render?: RenderProp<'button'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type ItemGroupProps =
	(PartProps<'div', Api['getItemGroupProps']>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type EmptyProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type ItemIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type ItemGroupLabelProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };

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
