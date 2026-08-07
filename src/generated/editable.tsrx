import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useEditable } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useEditable;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'activationMode',
		'autoResize',
		'defaultEdit',
		'defaultValue',
		'disabled',
		'edit',
		'finalFocusEl',
		'form',
		'id',
		'ids',
		'invalid',
		'maxLength',
		'name',
		'onEditChange',
		'onFocusOutside',
		'onInteractOutside',
		'onPointerDownOutside',
		'onValueChange',
		'onValueCommit',
		'onValueRevert',
		'placeholder',
		'readOnly',
		'required',
		'selectOnFocus',
		'submitMode',
		'translations',
		'value',
	],

	useMachine: useEditable as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const SubmitTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getSubmitTriggerProps',
});
export const Area = createPart({ context, defaultTag: 'div', getter: 'getAreaProps' });
export const EditTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getEditTriggerProps',
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });
export const Input = createPart({ context, defaultTag: 'input', getter: 'getInputProps' });
export const Preview = createPart({ context, defaultTag: 'span', getter: 'getPreviewProps' });
export const CancelTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getCancelTriggerProps',
});

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type LabelProps = ArkPartProps;
export type SubmitTriggerProps = ArkPartProps;
export type AreaProps = ArkPartProps;
export type EditTriggerProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type PreviewProps = ArkPartProps;
export type CancelTriggerProps = ArkPartProps;

export const Editable = {
	Root,
	RootProvider,
	Label,
	SubmitTrigger,
	Area,
	EditTrigger,
	Control,
	Input,
	Preview,
	CancelTrigger,
	Context,
};
