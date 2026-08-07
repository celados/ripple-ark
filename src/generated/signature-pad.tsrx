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

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
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
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Guide = createPart({ context, defaultTag: 'div', getter: 'getGuideProps' });
export const HiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
	propKeys: [
		'value',
	],
});
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const ClearTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Segment = createPart({ context, defaultTag: 'svg', getter: 'getSegmentProps' });

export const Context = createApiContext(context);

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
