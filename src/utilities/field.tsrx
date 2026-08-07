import { Context as RippleContext, track, type Children, type Tracked } from 'ripple';
import { fieldsetContext } from './fieldset.tsrx';

export type UseFieldProps = {
	id: string;
	disabled?: boolean;
	invalid?: boolean;
	readOnly?: boolean;
	required?: boolean;
	target?: string;
};

export type FieldApi = {
	disabled: boolean;
	invalid: boolean;
	readOnly: boolean;
	required: boolean;
	getRootProps: () => Record<string, unknown>;
	getLabelProps: () => Record<string, unknown>;
	getInputProps: () => Record<string, unknown>;
	getTextareaProps: () => Record<string, unknown>;
	getSelectProps: () => Record<string, unknown>;
	getHelperTextProps: () => Record<string, unknown>;
	getErrorTextProps: () => Record<string, unknown>;
	getRequiredIndicatorProps: () => Record<string, unknown>;
};

export function useField(props: UseFieldProps): Tracked<FieldApi> {
	const fieldset = fieldsetContext.get();
	return track(() => {
		const disabled = props.disabled ?? fieldset?.value.disabled ?? false;
		const invalid = props.invalid ?? fieldset?.value.invalid ?? false;
		const readOnly = props.readOnly ?? false;
		const required = props.required ?? false;
		const labelId = `${props.id}::label`;
		const helperTextId = `${props.id}::helper-text`;
		const errorTextId = `${props.id}::error-text`;
		const state = {
			'data-disabled': disabled ? '' : undefined,
			'data-invalid': invalid ? '' : undefined,
			'data-readonly': readOnly ? '' : undefined,
		};
		const control = {
			id: props.id,
			disabled: disabled || undefined,
			required: required || undefined,
			readOnly: readOnly || undefined,
			'aria-invalid': invalid ? true : undefined,
			'aria-describedby': `${helperTextId} ${errorTextId}`,
			...state,
		};
		return {
			disabled,
			invalid,
			readOnly,
			required,
			getRootProps: () => ({
				id: `${props.id}::root`,
				role: 'group',
				'data-scope': 'field',
				'data-part': 'root',
				...state,
			}),
			getLabelProps: () => ({
				id: labelId,
				htmlFor: props.target ? `${props.id}::item::${props.target}` : props.id,
				'data-scope': 'field',
				'data-part': 'label',
				'data-required': required ? '' : undefined,
				...state,
			}),
			getInputProps: () => ({ ...control, 'data-scope': 'field', 'data-part': 'input' }),
			getTextareaProps: () => ({ ...control, 'data-scope': 'field', 'data-part': 'textarea' }),
			getSelectProps: () => ({ ...control, 'data-scope': 'field', 'data-part': 'select' }),
			getHelperTextProps: () => ({
				id: helperTextId,
				'data-scope': 'field',
				'data-part': 'helper-text',
				'data-disabled': disabled ? '' : undefined,
			}),
			getErrorTextProps: () => ({
				id: errorTextId,
				'data-scope': 'field',
				'data-part': 'error-text',
				'aria-live': 'polite',
			}),
			getRequiredIndicatorProps: () => ({
				'aria-hidden': true,
				'data-scope': 'field',
				'data-part': 'required-indicator',
			}),
		};
	});
}

const context = /*#__PURE__*/ new RippleContext<Tracked<FieldApi> | null>(null);

export type FieldRootProps =
	Omit<JSX.IntrinsicElements['div'], 'id' | 'children'> & UseFieldProps & {
		children?: Children | Children[];
	};

export function FieldRoot(props: FieldRootProps) @{
	const { id, disabled, invalid, readOnly, required, target, children, ...localProps } = props;
	const api = useField({ id, disabled, invalid, readOnly, required, target });
	context.set(api);
	<div {...api.value.getRootProps()} {...localProps}>{children}</div>
}

export type FieldRootProviderProps =
	Omit<FieldRootProps, keyof UseFieldProps> & { value: Tracked<FieldApi> };

export function FieldRootProvider(props: FieldRootProviderProps) @{
	const { value, children, ...localProps } = props;
	context.set(value);
	<div {...value.value.getRootProps()} {...localProps}>{children}</div>
}

function useFieldContext() {
	const api = context.get();
	if (!api) throw new Error('Field part must be rendered inside Field.Root');
	return api;
}

export function FieldLabel(props: JSX.IntrinsicElements['label']) @{
	const api = useFieldContext();
	<label {...api.value.getLabelProps()} {...props} />
}
export function FieldInput(props: JSX.IntrinsicElements['input']) @{
	const api = useFieldContext();
	<input {...api.value.getInputProps()} {...props} />
}
export function FieldTextarea(props: JSX.IntrinsicElements['textarea']) @{
	const api = useFieldContext();
	<textarea {...api.value.getTextareaProps()} {...props} />
}
export function FieldSelect(props: JSX.IntrinsicElements['select']) @{
	const api = useFieldContext();
	<select {...api.value.getSelectProps()} {...props} />
}
export function FieldHelperText(props: JSX.IntrinsicElements['span']) @{
	const api = useFieldContext();
	<span {...api.value.getHelperTextProps()} {...props} />
}
export function FieldErrorText(props: JSX.IntrinsicElements['span']) @{
	const api = useFieldContext();
	<>
		@if (api.value.invalid) {
			<span {...api.value.getErrorTextProps()} {...props} />
		}
	</>
}
export function FieldRequiredIndicator(props: JSX.IntrinsicElements['span'] & {
	fallback?: Children;
}) @{
	const api = useFieldContext();
	const { fallback, children = '*', ...localProps } = props;
	<>
		@if (api.value.required) {
			<span {...api.value.getRequiredIndicatorProps()} {...localProps}>{children}</span>
		} @else {
			{
				fallback;
			}
		}
	</>
}
export function FieldItem(props: JSX.IntrinsicElements['div'] & { value: string }) @{
	const api = useFieldContext();
	const { value, ...localProps } = props;
	<div id={`${api.value.getInputProps().id}::item::${value}`} {...localProps} />
}
export function FieldContext(props: { children: (api: FieldApi) => Children }) @{
	const api = useFieldContext();
	const render = props.children;
	{
		render(api.value);
	}
}

export const Field = {
	Root: FieldRoot,
	RootProvider: FieldRootProvider,
	Label: FieldLabel,
	Input: FieldInput,
	Textarea: FieldTextarea,
	Select: FieldSelect,
	HelperText: FieldHelperText,
	ErrorText: FieldErrorText,
	RequiredIndicator: FieldRequiredIndicator,
	Item: FieldItem,
	Context: FieldContext,
};
