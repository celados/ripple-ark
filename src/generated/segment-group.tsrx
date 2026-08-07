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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const segmentGroupItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Item = /*#__PURE__*/ createPart({
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
export const ItemControl = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemControlProps',
	inheritedProps: segmentGroupItemProps,
});
export const ItemText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: segmentGroupItemProps,
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getLabelProps',
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
});
export const ItemHiddenInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getItemHiddenInputProps',
	inheritedProps: segmentGroupItemProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, segmentGroupItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

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
