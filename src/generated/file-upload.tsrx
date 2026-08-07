import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useFileUpload } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useFileUpload;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const fileUploadItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const fileUploadItemGroupProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'accept',
		'acceptedFiles',
		'allowDrop',
		'capture',
		'defaultAcceptedFiles',
		'directory',
		'disabled',
		'id',
		'ids',
		'invalid',
		'locale',
		'maxFiles',
		'maxFileSize',
		'minFileSize',
		'name',
		'onFileAccept',
		'onFileChange',
		'onFileReject',
		'preventDocumentDrop',
		'readOnly',
		'required',
		'translations',
		'transformFiles',
		'validate',
	],

	useMachine: useFileUpload as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const ItemSizeText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemSizeTextProps',
	inheritedProps: fileUploadItemProps,
});
export const Dropzone = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getDropzoneProps',
	propKeys: [
		'disableClick',
	],
});
export const ClearTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'li',
	getter: 'getItemProps',
	propKeys: [
		'file',
	],
	provideProps: fileUploadItemProps,
	inheritedProps: fileUploadItemGroupProps,
});
export const HiddenInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const ItemName = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemNameProps',
	inheritedProps: fileUploadItemProps,
});
export const ItemPreview = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemPreviewProps',
	inheritedProps: fileUploadItemProps,
});
export const ItemGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'ul',
	getter: 'getItemGroupProps',
	propKeys: [
		'type',
	],
	provideProps: fileUploadItemGroupProps,
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
});
export const ItemPreviewImage = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'img',
	getter: 'getItemPreviewImageProps',
	inheritedProps: fileUploadItemProps,
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const ItemDeleteTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getItemDeleteTriggerProps',
	inheritedProps: fileUploadItemProps,
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ItemSizeTextProps = ArkPartProps;
export type DropzoneProps = ArkPartProps;
export type ClearTriggerProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type HiddenInputProps = ArkPartProps;
export type ItemNameProps = ArkPartProps;
export type ItemPreviewProps = ArkPartProps;
export type ItemGroupProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ItemPreviewImageProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type ItemDeleteTriggerProps = ArkPartProps;

export const FileUpload = {
	Root,
	RootProvider,
	ItemSizeText,
	Dropzone,
	ClearTrigger,
	Item,
	HiddenInput,
	ItemName,
	ItemPreview,
	ItemGroup,
	Trigger,
	ItemPreviewImage,
	Label,
	ItemDeleteTrigger,
	Context,
};
