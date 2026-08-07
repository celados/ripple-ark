import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSignaturePad } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useSignaturePad;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'id',
		'ids',
		'defaultPaths',
		'drawing',
		'disabled',
		'readOnly',
		'name',
		'onDraw',
		'onDrawEnd',
		'paths',
		'readOnly',
		'required',
		'translations',
	],

	useMachine: useSignaturePad as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Guide = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getGuideProps',
});
export const HiddenInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
	propKeys: [
		'value',
	],
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const ClearTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Segment = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'svg',
	getter: 'getSegmentProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type GuideProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type ClearTriggerProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type SegmentProps = ArkPartProps;

export const SignaturePad = {
	Root,
	RootProvider,
	Guide,
	HiddenInput,
	Label,
	ClearTrigger,
	Control,
	Segment,
	Context,
};
