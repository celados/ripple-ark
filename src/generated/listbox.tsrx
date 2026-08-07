import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useListbox } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useListbox;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const listboxItemGroupProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const listboxItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [],

	useMachine: useListbox as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const ItemGroupLabel = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupLabelProps',
	inheritedProps: listboxItemGroupProps,
});
export const Input = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
	propKeys: [
		'autoHighlight',
		'keyboardPriority',
	],
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'item',
		'highlightOnHover',
	],
	provideProps: listboxItemProps,
});
export const ValueText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getValueTextProps',
});
export const Empty = /*#__PURE__*/ createPart({ context, defaultTag: 'div' });
export const ItemIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: listboxItemProps,
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getLabelProps',
});
export const ItemText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemTextProps',
	inheritedProps: listboxItemProps,
});
export const ItemGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
	provideProps: listboxItemGroupProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, listboxItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ItemGroupLabelProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type EmptyProps = ArkPartProps;
export type ItemIndicatorProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type ItemGroupProps = ArkPartProps;

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
