import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useEditable } from '../components';
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

type Hook = typeof useEditable;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function SubmitTrigger(props: SubmitTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getSubmitTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Area(props: AreaProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getAreaProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function EditTrigger(props: EditTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getEditTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Input(props: InputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Preview(props: PreviewProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getPreviewProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function CancelTrigger(props: CancelTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getCancelTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type SubmitTriggerProps = PartProps<'button', Api['getSubmitTriggerProps']>;
export type AreaProps = PartProps<'div', Api['getAreaProps']>;
export type EditTriggerProps = PartProps<'button', Api['getEditTriggerProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type PreviewProps = PartProps<'span', Api['getPreviewProps']>;
export type CancelTriggerProps = PartProps<'button', Api['getCancelTriggerProps']>;

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
