import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCheckbox } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useCheckbox;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'label',
	configKeys: [
		'checked',
		'defaultChecked',
		'disabled',
		'form',
		'id',
		'ids',
		'invalid',
		'name',
		'onCheckedChange',
		'readOnly',
		'required',
		'value',
	],

	useMachine: useCheckbox as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'label' });
export const HiddenInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const GroupProvider = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	propKeys: [
		'value',
	],
});
export const Group = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	propKeys: [
		'defaultValue',
		'value',
		'onValueChange',
		'disabled',
		'invalid',
		'readOnly',
		'name',
		'maxSelectedValues',
	],
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
	propKeys: [
		'indeterminate',
	],
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type HiddenInputProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type GroupProviderProps = ArkPartProps;
export type GroupProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;

export const Checkbox = {
	Root,
	RootProvider,
	HiddenInput,
	Control,
	GroupProvider,
	Group,
	Label,
	Indicator,
	Context,
};
