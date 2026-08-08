import { Context as RippleContext, track, type Children, type Tracked } from 'ripple';

export type UseFieldsetProps = {
	id: string;
	disabled?: boolean;
	invalid?: boolean;
};

export type FieldsetApi = {
	disabled: boolean;
	invalid: boolean;
	getRootProps: () => Record<string, unknown>;
	getLegendProps: () => Record<string, unknown>;
	getHelperTextProps: () => Record<string, unknown>;
	getErrorTextProps: () => Record<string, unknown>;
};

export function useFieldset(props: UseFieldsetProps): Tracked<FieldsetApi> {
	return track(() => {
		const legendId = `${props.id}::legend`;
		const helperTextId = `${props.id}::helper-text`;
		const errorTextId = `${props.id}::error-text`;
		return {
			disabled: props.disabled ?? false,
			invalid: props.invalid ?? false,
			getRootProps: () => ({
				'data-scope': 'fieldset',
				'data-part': 'root',
				disabled: props.disabled || undefined,
				'data-disabled': props.disabled ? '' : undefined,
				'data-invalid': props.invalid ? '' : undefined,
				'aria-labelledby': legendId,
				'aria-describedby': `${helperTextId} ${errorTextId}`,
			}),
			getLegendProps: () => ({
				id: legendId,
				'data-scope': 'fieldset',
				'data-part': 'legend',
				'data-disabled': props.disabled ? '' : undefined,
				'data-invalid': props.invalid ? '' : undefined,
			}),
			getHelperTextProps: () => ({
				id: helperTextId,
				'data-scope': 'fieldset',
				'data-part': 'helper-text',
			}),
			getErrorTextProps: () => ({
				id: errorTextId,
				'data-scope': 'fieldset',
				'data-part': 'error-text',
				'aria-live': 'polite',
			}),
		};
	});
}

export const fieldsetContext = /*#__PURE__*/ new RippleContext<Tracked<FieldsetApi> | null>(null);

export type FieldsetRootProps =
	Omit<JSX.IntrinsicElements['fieldset'], 'id' | 'children'> & UseFieldsetProps & {
		children?: Children | Children[];
	};

export function FieldsetRoot(props: FieldsetRootProps) @{
	let &{ id: _id, disabled: _disabled, invalid: _invalid, children, ...localProps } = props;
	const api = useFieldset(props);
	fieldsetContext.set(api);
	<fieldset {...api.value.getRootProps()} {...localProps}>{children}</fieldset>
}

export type FieldsetRootProviderProps =
	Omit<FieldsetRootProps, keyof UseFieldsetProps> & {
		value: Tracked<FieldsetApi>;
	};

export function FieldsetRootProvider(props: FieldsetRootProviderProps) @{
	let &{ value, children, ...localProps } = props;
	const api = track(() => value.value);
	fieldsetContext.set(api);
	<fieldset {...api.value.getRootProps()} {...localProps}>{children}</fieldset>
}

export function FieldsetLegend(props: JSX.IntrinsicElements['legend']) @{
	const api = fieldsetContext.get();
	if (!api) throw new Error('Fieldset.Legend must be rendered inside Fieldset.Root');
	<legend {...api.value.getLegendProps()} {...props} />
}

export function FieldsetHelperText(props: JSX.IntrinsicElements['span']) @{
	const api = fieldsetContext.get();
	if (!api) throw new Error('Fieldset.HelperText must be rendered inside Fieldset.Root');
	<span {...api.value.getHelperTextProps()} {...props} />
}

export function FieldsetErrorText(props: JSX.IntrinsicElements['span']) @{
	const api = fieldsetContext.get();
	if (!api) throw new Error('Fieldset.ErrorText must be rendered inside Fieldset.Root');
	<>
		@if (api.value.invalid) {
			<span {...api.value.getErrorTextProps()} {...props} />
		}
	</>
}

export function FieldsetContext(props: { render: (api: FieldsetApi) => Children }) @{
	const api = fieldsetContext.get();
	if (!api) throw new Error('Fieldset.Context must be rendered inside Fieldset.Root');
	const Content = () => props.render(api.value);
	<{Content} />
}

export const Fieldset = {
	Root: FieldsetRoot,
	RootProvider: FieldsetRootProvider,
	Legend: FieldsetLegend,
	HelperText: FieldsetHelperText,
	ErrorText: FieldsetErrorText,
	Context: FieldsetContext,
};
