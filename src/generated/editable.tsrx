import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useEditable } from '../components';
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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const SubmitTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getSubmitTriggerProps',
});
export const Area = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getAreaProps',
});
export const EditTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getEditTriggerProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Input = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
});
export const Preview = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getPreviewProps',
});
export const CancelTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getCancelTriggerProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

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
