import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useFileUpload } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useFileUpload;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const fileUploadItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);
const fileUploadItemGroupProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
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
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemSizeText(props: ItemSizeTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemSizeTextProps', inheritedProps: fileUploadItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Dropzone(props: DropzoneProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getDropzoneProps',
			propKeys: [
				'disableClick',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ClearTrigger(props: ClearTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getClearTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Item(props: ItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'file',
			],
			provideProps: fileUploadItemProps,
			inheritedProps: fileUploadItemGroupProps,
		},
		props,
	);
	<li {...mergedProps.value}>{children}</li>
}
export function HiddenInput(props: HiddenInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}
export function ItemName(props: ItemNameProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemNameProps', inheritedProps: fileUploadItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemPreview(props: ItemPreviewProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemPreviewProps', inheritedProps: fileUploadItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemGroup(props: ItemGroupProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemGroupProps',
			propKeys: [
				'type',
			],
			provideProps: fileUploadItemGroupProps,
		},
		props,
	);
	<ul {...mergedProps.value}>{children}</ul>
}
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function ItemPreviewImage(props: ItemPreviewImageProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemPreviewImageProps', inheritedProps: fileUploadItemProps },
		props,
	);
	<img {...mergedProps.value} />
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function ItemDeleteTrigger(props: ItemDeleteTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemDeleteTriggerProps', inheritedProps: fileUploadItemProps },
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ItemSizeTextProps = ArkPartProps<'div'>;
export type DropzoneProps = PartProps<'div', Api['getDropzoneProps']>;
export type ClearTriggerProps = PartProps<'button', Api['getClearTriggerProps']>;
export type ItemProps =
	ArkPartProps<'li'> & Pick<
		GetterProps<Api['getItemProps']>,
		Extract<keyof GetterProps<Api['getItemProps']>, 'file'>
	>;
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;
export type ItemNameProps = ArkPartProps<'div'>;
export type ItemPreviewProps = ArkPartProps<'div'>;
export type ItemGroupProps = PartProps<'ul', Api['getItemGroupProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ItemPreviewImageProps = ArkPartProps<'img'>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type ItemDeleteTriggerProps = ArkPartProps<'button'>;

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
