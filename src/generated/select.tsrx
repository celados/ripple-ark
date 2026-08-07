import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSelect } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useSelect;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const selectItemProps = new RippleContext<Record<string, any> | null>(null);
const selectItemGroupProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [],

	useMachine: useSelect as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const List = createPart({ context, defaultTag: 'div', getter: 'getListProps' });
export const Trigger = createPart({ context, defaultTag: 'button', getter: 'getTriggerProps' });
export const ItemIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: selectItemProps,
});
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const HiddenSelect = createPart({
	context,
	defaultTag: 'select',
	getter: 'getHiddenSelectProps',
});
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const ClearTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const ItemText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: selectItemProps,
});
export const ItemGroup = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
	provideProps: selectItemGroupProps,
});
export const ItemGroupLabel = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupLabelProps',
	inheritedProps: selectItemGroupProps,
});
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'item',
		'persistFocus',
	],
	provideProps: selectItemProps,
});
export const ValueText = createPart({ context, defaultTag: 'span', getter: 'getValueTextProps' });
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const ItemContext = createItemContext(context, selectItemProps);

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ListProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ItemIndicatorProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type HiddenSelectProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type ClearTriggerProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type ItemGroupProps = ArkPartProps;
export type ItemGroupLabelProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type LabelProps = ArkPartProps;

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
