import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useListbox } from '../components';
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

type Hook = typeof useListbox;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const listboxItemGroupProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const listboxItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [],

			useMachine: useListbox as any,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemGroupLabelProps', inheritedProps: listboxItemGroupProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Input(props: InputProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getInputProps',
			propKeys: [
				'autoHighlight',
				'keyboardPriority',
			],
		},
		props,
	);
	<input {...mergedProps.value} />
}
export function Content(props: ContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'item',
				'highlightOnHover',
			],
			provideProps: listboxItemProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ValueText(props: ValueTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getValueTextProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Empty(props: EmptyProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: listboxItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function ItemText(props: ItemTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: listboxItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroup(props: ItemGroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemGroupProps', provideProps: listboxItemGroupProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, listboxItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ItemGroupLabelProps = ArkPartProps<'div'>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ValueTextProps = PartProps<'span', Api['getValueTextProps']>;
export type EmptyProps = ArkPartProps<'div'>;
export type ItemIndicatorProps = ArkPartProps<'div'>;
export type LabelProps = PartProps<'span', Api['getLabelProps']>;
export type ItemTextProps = ArkPartProps<'div'>;
export type ItemGroupProps = PartProps<'div', Api['getItemGroupProps']>;

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
