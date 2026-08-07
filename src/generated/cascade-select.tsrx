import { Context as RippleContext, type Tracked } from 'ripple';
import { useCascadeSelect } from '../components';
import {
	createApiContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Api = Record<string, any>;
const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const itemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getIndicatorProps',
});
export const ClearTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const List = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'ul',
	getter: 'getListProps',
	propKeys: ['indexPath', 'value', 'item'],
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'li',
	getter: 'getItemProps',
	propKeys: ['indexPath', 'value', 'item'],
	provideProps: itemProps,
});
export const ItemText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: itemProps,
});
export const ItemIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemIndicatorProps',
	inheritedProps: itemProps,
});
export const Context = /*#__PURE__*/ createApiContext(context);

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
