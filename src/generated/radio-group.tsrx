import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useRadioGroup } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useRadioGroup;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const radioGroupItemProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'defaultValue',
		'disabled',
		'form',
		'id',
		'ids',
		'invalid',
		'name',
		'onValueChange',
		'orientation',
		'readOnly',
		'required',
		'value',
	],

	useMachine: useRadioGroup as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Label = createPart({ context, defaultTag: 'span', getter: 'getLabelProps' });
export const ItemText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: radioGroupItemProps,
});
export const ItemControl = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemControlProps',
	inheritedProps: radioGroupItemProps,
});
export const ItemHiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getItemHiddenInputProps',
	inheritedProps: radioGroupItemProps,
});
export const Item = createPart({
	context,
	defaultTag: 'label',
	getter: 'getItemProps',
	propKeys: [
		'value',
		'disabled',
		'invalid',
	],
	provideProps: radioGroupItemProps,
});
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });
export const ItemContext = createItemContext(context, radioGroupItemProps);

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type LabelProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type ItemControlProps = ArkPartProps;
export type ItemHiddenInputProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;

export const RadioGroup = {
	Root,
	RootProvider,
	Label,
	ItemText,
	ItemControl,
	ItemHiddenInput,
	Item,
	Indicator,
	ItemContext,
	Context,
};
