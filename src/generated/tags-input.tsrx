import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTagsInput } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useTagsInput;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const tagsInputItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'addOnPaste',
		'allowDuplicates',
		'allowOverflow',
		'autoFocus',
		'blurBehavior',
		'defaultInputValue',
		'defaultValue',
		'delimiter',
		'disabled',
		'editable',
		'form',
		'id',
		'ids',
		'inputValue',
		'invalid',
		'max',
		'maxLength',
		'name',
		'onFocusOutside',
		'onHighlightChange',
		'onInputValueChange',
		'onInteractOutside',
		'onPointerDownOutside',
		'onValueChange',
		'onValueInvalid',
		'placeholder',
		'readOnly',
		'required',
		'translations',
		'validate',
		'value',
		'sanitizeValue',
	],

	useMachine: useTagsInput as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
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
export const ItemText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: tagsInputItemProps,
});
export const ItemInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getItemInputProps',
	inheritedProps: tagsInputItemProps,
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const HiddenInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const ItemPreview = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemPreviewProps',
	inheritedProps: tagsInputItemProps,
});
export const Input = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getInputProps',
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'disabled',
		'index',
		'value',
	],
	provideProps: tagsInputItemProps,
});
export const ItemDeleteTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getItemDeleteTriggerProps',
	inheritedProps: tagsInputItemProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, tagsInputItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type LabelProps = ArkPartProps;
export type ClearTriggerProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;
export type ItemInputProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;
export type ItemPreviewProps = ArkPartProps;
export type InputProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ItemDeleteTriggerProps = ArkPartProps;

export const TagsInput = {
	Root,
	RootProvider,
	Label,
	ClearTrigger,
	ItemText,
	ItemInput,
	Control,
	HiddenInput,
	ItemPreview,
	Input,
	Item,
	ItemDeleteTrigger,
	ItemContext,
	Context,
};
