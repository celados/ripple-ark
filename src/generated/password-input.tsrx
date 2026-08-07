import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePasswordInput } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof usePasswordInput;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'autoComplete',
		'defaultVisible',
		'disabled',
		'id',
		'ids',
		'ignorePasswordManagers',
		'invalid',
		'name',
		'onVisibilityChange',
		'readOnly',
		'required',
		'translations',
		'visible',
	],

	useMachine: usePasswordInput as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Input = createPart({ context, defaultTag: 'input', getter: 'getInputProps' });
export const Indicator = createPart({ context, defaultTag: 'span', getter: 'getIndicatorProps' });
export const VisibilityTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getVisibilityTriggerProps',
});
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ControlProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type VisibilityTriggerProps = ArkPartProps;
export type LabelProps = ArkPartProps;

export const PasswordInput = {
	Root,
	RootProvider,
	Control,
	Input,
	Indicator,
	VisibilityTrigger,
	Label,
	Context,
};
