import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCombobox } from '../components';
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

type Hook = typeof useCombobox;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const comboboxItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const comboboxItemGroupProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [],

			useMachine: useCombobox as any,
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
export function List(props: ListProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getListProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Input(props: InputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getInputProps' }, props);
	<input {...mergedProps.value} />
}
export function ItemText(props: ItemTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: comboboxItemProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function ClearTrigger(props: ClearTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getClearTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Positioner(props: PositionerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroup(props: ItemGroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemGroupProps', provideProps: comboboxItemGroupProps },
		props,
	);
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
				'persistFocus',
			],
			provideProps: comboboxItemProps,
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
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'focusable',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Empty(props: EmptyProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: comboboxItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroupLabel(props: ItemGroupLabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemGroupLabelProps', inheritedProps: comboboxItemGroupProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, comboboxItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ListProps = PartProps<'div', Api['getListProps']>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type ItemTextProps = ArkPartProps<'span'>;
export type ClearTriggerProps = PartProps<'button', Api['getClearTriggerProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ItemGroupProps = PartProps<'div', Api['getItemGroupProps']>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type EmptyProps = ArkPartProps<'div'>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type ItemIndicatorProps = ArkPartProps<'div'>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type ItemGroupLabelProps = ArkPartProps<'div'>;

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
