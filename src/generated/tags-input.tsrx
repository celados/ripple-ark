import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTagsInput } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getClearTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getItemTextProps', inheritedProps: tagsInputItemProps }}
		of={props}
	>{children}</Part>
}
export function ItemInput(props: ItemInputProps) @{
	<Part
		tag="input"
		options={{ context, getter: 'getItemInputProps', inheritedProps: tagsInputItemProps }}
		of={props}
	/>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function HiddenInput(props: HiddenInputProps) @{
	<Part tag="input" options={{ context, getter: 'getHiddenInputProps' }} of={props} />
}
export function ItemPreview(props: ItemPreviewProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemPreviewProps', inheritedProps: tagsInputItemProps }}
		of={props}
	>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part tag="input" options={{ context, getter: 'getInputProps' }} of={props} />
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getItemProps',
			propKeys: [
				'disabled',
				'index',
				'value',
			],
			provideProps: tagsInputItemProps,
		}}
		of={props}
	>{children}</Part>
}
export function ItemDeleteTrigger(props: ItemDeleteTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getItemDeleteTriggerProps', inheritedProps: tagsInputItemProps }}
		of={props}
	>{children}</Part>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, tagsInputItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type ClearTriggerProps =
	(PartProps<'button', Api['getClearTriggerProps']>) & { render?: RenderProp<'button'> };
export type ItemTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type ItemInputProps = (ArkPartProps<'input'>) & { render?: RenderProp<'input'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type ItemPreviewProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ItemDeleteTriggerProps = (ArkPartProps<'button'>) & { render?: RenderProp<'button'> };

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
