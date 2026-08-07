import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSwitch } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useSwitch;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
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
		'label',
		'name',
		'onCheckedChange',
		'readOnly',
		'required',
		'value',
	],

	useMachine: useSwitch as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'label' });
export const Control = createPart({ context, defaultTag: 'span', getter: 'getControlProps' });
export const Label = createPart({ context, defaultTag: 'span', getter: 'getLabelProps' });
export const HiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const Thumb = createPart({ context, defaultTag: 'span', getter: 'getThumbProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ControlProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;
export type ThumbProps = ArkPartProps;

export const Switch = { Root, RootProvider, Control, Label, HiddenInput, Thumb, Context };
