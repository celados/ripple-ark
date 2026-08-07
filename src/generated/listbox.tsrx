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

const context = new RippleContext<Tracked<Api> | null>(null);

const listboxItemGroupProps = new RippleContext<Record<string, any> | null>(null);
const listboxItemProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [],

	useMachine: useListbox as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const ItemGroupLabel = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupLabelProps',
	inheritedProps: listboxItemGroupProps,
});
export const Input = createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
	propKeys: [
		'autoHighlight',
		'keyboardPriority',
	],
});
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'item',
		'highlightOnHover',
	],
	provideProps: listboxItemProps,
});
export const ValueText = createPart({ context, defaultTag: 'span', getter: 'getValueTextProps' });
export const Empty = createPart({ context, defaultTag: 'div' });
export const ItemIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: listboxItemProps,
});
export const Label = createPart({ context, defaultTag: 'span', getter: 'getLabelProps' });
export const ItemText = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemTextProps',
	inheritedProps: listboxItemProps,
});
export const ItemGroup = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
	provideProps: listboxItemGroupProps,
});
export const ItemContext = createItemContext(context, listboxItemProps);

export const Context = createApiContext(context);

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
