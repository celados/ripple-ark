import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAccordion } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useAccordion;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const accordionItemProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'collapsible',
		'defaultValue',
		'disabled',
		'id',
		'ids',
		'multiple',
		'onFocusChange',
		'onValueChange',
		'orientation',
		'value',
	],

	useMachine: useAccordion as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const ItemIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: accordionItemProps,
});
export const ItemContent = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemContentProps',
	inheritedProps: accordionItemProps,
});
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'value',
		'disabled',
	],
	provideProps: accordionItemProps,
});
export const ItemTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getItemTriggerProps',
	inheritedProps: accordionItemProps,
});
export const ItemContext = createItemContext(context, accordionItemProps);

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ItemIndicatorProps = ArkPartProps;
export type ItemContentProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ItemTriggerProps = ArkPartProps;

export const Accordion = {
	Root,
	RootProvider,
	ItemIndicator,
	ItemContent,
	Item,
	ItemTrigger,
	ItemContext,
	Context,
};
