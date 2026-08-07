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

const context = new RippleContext<Tracked<Api> | null>(null);

const fileUploadItemProps = new RippleContext<Record<string, any> | null>(null);
const fileUploadItemGroupProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
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
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const ItemSizeText = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemSizeTextProps',
	inheritedProps: fileUploadItemProps,
});
export const Dropzone = createPart({
	context,
	defaultTag: 'div',
	getter: 'getDropzoneProps',
	propKeys: [
		'disableClick',
	],
});
export const ClearTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getClearTriggerProps',
});
export const Item = createPart({
	context,
	defaultTag: 'li',
	getter: 'getItemProps',
	propKeys: [
		'file',
	],
	provideProps: fileUploadItemProps,
	inheritedProps: fileUploadItemGroupProps,
});
export const HiddenInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const ItemName = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemNameProps',
	inheritedProps: fileUploadItemProps,
});
export const ItemPreview = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemPreviewProps',
	inheritedProps: fileUploadItemProps,
});
export const ItemGroup = createPart({
	context,
	defaultTag: 'ul',
	getter: 'getItemGroupProps',
	propKeys: [
		'type',
	],
	provideProps: fileUploadItemGroupProps,
});
export const Trigger = createPart({ context, defaultTag: 'button', getter: 'getTriggerProps' });
export const ItemPreviewImage = createPart({
	context,
	defaultTag: 'img',
	getter: 'getItemPreviewImageProps',
	inheritedProps: fileUploadItemProps,
});
export const Label = createPart({ context, defaultTag: 'label', getter: 'getLabelProps' });
export const ItemDeleteTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getItemDeleteTriggerProps',
	inheritedProps: fileUploadItemProps,
});

export const Context = createApiContext(context);

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
