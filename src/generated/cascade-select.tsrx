import { Context as RippleContext, type Tracked } from 'ripple';
import { useCascadeSelect } from '../components.ts';
import {
	createApiContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Api = Record<string, any>;
const context = new RippleContext<Tracked<Api> | null>(null);
const itemProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'id',
		'collection',
		'defaultValue',
		'value',
		'onValueChange',
		'disabled',
		'invalid',
		'readOnly',
		'required',
		'open',
		'defaultOpen',
		'onOpenChange',
		'positioning',
	],
	useMachine: useCascadeSelect as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Trigger = createPart({ context, defaultTag: 'button', getter: 'getTriggerProps' });
export const Indicator = createPart({ context, defaultTag: 'span', getter: 'getIndicatorProps' });
export const ClearTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });
export const List = createPart({
	context,
	defaultTag: 'ul',
	getter: 'getListProps',
	propKeys: ['indexPath', 'value', 'item'],
});
export const Item = createPart({
	context,
	defaultTag: 'li',
	getter: 'getItemProps',
	propKeys: ['indexPath', 'value', 'item'],
	provideProps: itemProps,
});
export const ItemText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: itemProps,
});
export const ItemIndicator = createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemIndicatorProps',
	inheritedProps: itemProps,
});
export const Context = createApiContext(context);

export type RootProps = ArkPartProps;
export const CascadeSelect = {
	Root,
	RootProvider,
	Label,
	Control,
	Trigger,
	Indicator,
	ClearTrigger,
	Positioner,
	Content,
	List,
	Item,
	ItemText,
	ItemIndicator,
	Context,
};
