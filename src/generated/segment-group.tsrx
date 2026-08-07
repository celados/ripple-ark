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

const segmentGroupItemProps = new RippleContext<Record<string, any> | null>(null);

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
export const Item = createPart({
	context,
	defaultTag: 'label',
	getter: 'getItemProps',
	propKeys: [
		'value',
		'disabled',
		'invalid',
	],
	provideProps: segmentGroupItemProps,
});
export const ItemControl = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemControlProps',
	inheritedProps: segmentGroupItemProps,
});
export const ItemText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: segmentGroupItemProps,
});
export const Label = createPart({ context, defaultTag: 'span', getter: 'getLabelProps' });
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });
export const ItemHiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getItemHiddenInputProps',
	inheritedProps: segmentGroupItemProps,
});
export const ItemContext = createItemContext(context, segmentGroupItemProps);

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ItemProps = ArkPartProps;
export type ItemControlProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type ItemHiddenInputProps = ArkPartProps;

export const SegmentGroup = {
	Root,
	RootProvider,
	Item,
	ItemControl,
	ItemText,
	Label,
	Indicator,
	ItemHiddenInput,
	ItemContext,
	Context,
};
