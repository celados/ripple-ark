import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { mergeProps } from '@zag-js/core';
import { useFileUpload } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	createRenderContent,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useFileUpload;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const fileUploadItemProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);
const fileUploadItemGroupProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ItemSizeText(props: ItemSizeTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const itemProps = fileUploadItemProps.get()!;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemSizeTextProps', inheritedProps: fileUploadItemProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children || api.value.getFileSize(itemProps.value.file)}</div>
	}
}
export function Dropzone(props: DropzoneProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getClearTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<li {...mergedProps.value}>{children}</li>
	}
}
export function HiddenInput(props: HiddenInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<input {...mergedProps.value} />
	}
}
export function ItemName(props: ItemNameProps) @{
	let &{ children } = props;
	const itemProps = fileUploadItemProps.get()!;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemNameProps', inheritedProps: fileUploadItemProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children || itemProps.value.file.name}</div>
	}
}
export function ItemPreview(props: ItemPreviewProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemPreviewProps', inheritedProps: fileUploadItemProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ItemGroup(props: ItemGroupProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<ul {...mergedProps.value}>{children}</ul>
	}
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function ItemPreviewImage(props: ItemPreviewImageProps) @{
	let &{ children, render: _render, ...localProps } = props;
	const api = context.get();
	if (
		!api
	) throw new Error('FileUpload.ItemPreviewImage must be rendered inside FileUpload.Root or RootProvider');
	const itemProps = fileUploadItemProps.get();
	if (
		!itemProps
	) throw new Error('FileUpload.ItemPreviewImage must be rendered inside FileUpload.Item');
	const url = track('');
	effect(() => {
		return api.value.createFileUrl(itemProps.value.file, (nextUrl) => {
			url.value = nextUrl;
		});
	});
	const mergedProps = track(
		() => mergeProps(
			api.value.getItemPreviewImageProps({ ...itemProps.value, url: url.value } as any),
			localProps,
		),
	);
	@if (url.value) {
		@if (props.render) {
			const Content = createRenderContent(mergedProps, props.render);
			<{Content} />
		} @else {
			<img {...mergedProps.value} />
		}
	}
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<label {...mergedProps.value}>{children}</label>
	}
}
export function ItemDeleteTrigger(props: ItemDeleteTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemDeleteTriggerProps', inheritedProps: fileUploadItemProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ItemSizeTextProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type DropzoneProps =
	(PartProps<'div', Api['getDropzoneProps']>) & { render?: RenderProp<'div'> };
export type ClearTriggerProps =
	(PartProps<'button', Api['getClearTriggerProps']>) & { render?: RenderProp<'button'> };
export type ItemProps =
	(ArkPartProps<'li'> & Pick<
		GetterProps<Api['getItemProps']>,
		Extract<keyof GetterProps<Api['getItemProps']>, 'file'>
	>) & { render?: RenderProp<'li'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type ItemNameProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemPreviewProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemGroupProps =
	(PartProps<'ul', Api['getItemGroupProps']>) & { render?: RenderProp<'ul'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ItemPreviewImageProps = (ArkPartProps<'img'>) & { render?: RenderProp<'img'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type ItemDeleteTriggerProps = (ArkPartProps<'button'>) & { render?: RenderProp<'button'> };

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
