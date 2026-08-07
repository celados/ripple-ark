import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAngleSlider } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useAngleSlider;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'id',
		'ids',
		'name',
		'invalid',
		'readOnly',
		'disabled',
		'onValueChangeEnd',
		'onValueChange',
		'defaultValue',
		'value',
		'step',
		'aria-label',
		'aria-labelledby',
	],

	useMachine: useAngleSlider as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Thumb = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getThumbProps',
});
export const ValueText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getValueTextProps',
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const MarkerGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getMarkerGroupProps',
});
export const Marker = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getMarkerProps',
	propKeys: [
		'value',
	],
});
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

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ThumbProps = ArkPartProps;
export type ValueTextProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type MarkerGroupProps = ArkPartProps;
export type MarkerProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;
export type ControlProps = ArkPartProps;

export const AngleSlider = {
	Root,
	RootProvider,
	Thumb,
	ValueText,
	Label,
	MarkerGroup,
	Marker,
	HiddenInput,
	Control,
	Context,
};
