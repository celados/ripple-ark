import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useListbox } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useListbox;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const listboxItemGroupProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);
const listboxItemProps = /*#__PURE__*/ new RippleContext<Tracked<Record<string, any>> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'collection',
				'defaultHighlightedValue',
				'defaultValue',
				'deselectable',
				'disabled',
				'disallowSelectAll',
				'highlightedValue',
				'id',
				'ids',
				'loopFocus',
				'onHighlightChange',
				'onSelect',
				'onValueChange',
				'orientation',
				'scrollToIndexFn',
				'selectionMode',
				'selectOnHighlight',
				'typeahead',
				'value',
			],

			useMachine: useListbox as any,
		},
		props,
	);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemGroupLabelProps', inheritedProps: listboxItemGroupProps }}
		of={props}
	>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part
		tag="input"
		options={{
			context,
			getter: 'getInputProps',
			propKeys: [
				'autoHighlight',
				'keyboardPriority',
			],
		}}
		of={props}
	/>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getContentProps' }} of={props}>{children}</Part>
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
				'highlightOnHover',
			],
			provideProps: listboxItemProps,
		}}
		of={props}
	>{children}</Part>
}
export function ValueText(props: ValueTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	<Part
		tag="span"
		options={{
			context,
			getter: 'getValueTextProps',
			propKeys: [
				'placeholder',
			],
		}}
		of={props}
	>
		{children || api.value.valueAsString || (props as any).placeholder}
	</Part>
}
export function Empty(props: EmptyProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context }} of={props}>{children}</Part>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemIndicatorProps', inheritedProps: listboxItemProps }}
		of={props}
	>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemTextProps', inheritedProps: listboxItemProps }}
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
			provideProps: listboxItemGroupProps,
		}}
		of={props}
	>{children}</Part>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, listboxItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ItemGroupLabelProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ValueTextProps =
	(PartProps<'span', Api['getValueTextProps']> & { placeholder?: string }) & {
		render?: RenderProp<'span'>;
	};
export type EmptyProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'span', Api['getLabelProps']>) & { render?: RenderProp<'span'> };
export type ItemTextProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemGroupProps =
	(PartProps<'div', Api['getItemGroupProps']>) & { render?: RenderProp<'div'> };

export const Listbox = {
	Root,
	RootProvider,
	ItemGroupLabel,
	Input,
	Content,
	Item,
	ValueText,
	Empty,
	ItemIndicator,
	Label,
	ItemText,
	ItemGroup,
	ItemContext,
	Context,
};
