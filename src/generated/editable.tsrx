import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useEditable } from '../components';
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

type Hook = typeof useEditable;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
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
export function SubmitTrigger(props: SubmitTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getSubmitTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Area(props: AreaProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getAreaProps' }} of={props}>{children}</Part>
}
export function EditTrigger(props: EditTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getEditTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part tag="input" options={{ context, getter: 'getInputProps' }} of={props} />
}
export function Preview(props: PreviewProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context, getter: 'getPreviewProps' }} of={props}>{children}</Part>
}
export function CancelTrigger(props: CancelTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getCancelTriggerProps' }}
		of={props}
	>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type SubmitTriggerProps =
	(PartProps<'button', Api['getSubmitTriggerProps']>) & { render?: RenderProp<'button'> };
export type AreaProps = (PartProps<'div', Api['getAreaProps']>) & { render?: RenderProp<'div'> };
export type EditTriggerProps =
	(PartProps<'button', Api['getEditTriggerProps']>) & { render?: RenderProp<'button'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };
export type PreviewProps =
	(PartProps<'span', Api['getPreviewProps']>) & { render?: RenderProp<'span'> };
export type CancelTriggerProps =
	(PartProps<'button', Api['getCancelTriggerProps']>) & { render?: RenderProp<'button'> };

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
