import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTagsInput } from '../components';
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

type Hook = typeof useTagsInput;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const tagsInputItemProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
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
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getClearTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: tagsInputItemProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function ItemInput(props: ItemInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemInputProps', inheritedProps: tagsInputItemProps },
		props,
	);
	<input {...mergedProps.value} />
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function HiddenInput(props: HiddenInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}
export function ItemPreview(props: ItemPreviewProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemPreviewProps', inheritedProps: tagsInputItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Input(props: InputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'disabled',
				'index',
				'value',
			],
			provideProps: tagsInputItemProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemDeleteTrigger(props: ItemDeleteTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemDeleteTriggerProps', inheritedProps: tagsInputItemProps },
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, tagsInputItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type ClearTriggerProps = PartProps<'button', Api['getClearTriggerProps']>;
export type ItemTextProps = ArkPartProps<'span'>;
export type ItemInputProps = ArkPartProps<'input'>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;
export type ItemPreviewProps = ArkPartProps<'div'>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ItemDeleteTriggerProps = ArkPartProps<'button'>;

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
