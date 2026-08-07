import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAccordion } from '../components';
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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const accordionItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const ItemIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: accordionItemProps,
});
export const ItemContent = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemContentProps',
	inheritedProps: accordionItemProps,
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'value',
		'disabled',
	],
	provideProps: accordionItemProps,
});
export const ItemTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getItemTriggerProps',
	inheritedProps: accordionItemProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, accordionItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

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
