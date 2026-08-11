import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { anatomy } from '@zag-js/checkbox';
import { useCheckbox } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	splitProps,
	createRenderContent,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useCheckbox;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const checkboxGroupContext = /*#__PURE__*/ new RippleContext<
	Tracked<CheckboxGroupApi> | null
>(null);
const checkboxGroupAnatomyAttrs = /*#__PURE__*/ anatomy.extendWith('group').build().group.attrs;

export function Root(props: RootProps) @{
	let &{ children } = props;
	const group = checkboxGroupContext.get();
	const groupItemProps =
		group
			? track(() => group.value.getItemProps({ value: (props as AnyRecord).value }))
			: undefined;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'checked',
				'defaultChecked',
				'disabled',
				'form',
				'id',
				'ids',
				'invalid',
				'name',
				'onCheckedChange',
				'readOnly',
				'required',
				'value',
			],
			machineDefaults: groupItemProps
				? {
						checked: () => groupItemProps.value.checked,
						onCheckedChange: () => groupItemProps.value.onCheckedChange,
						name: () => groupItemProps.value.name,
						disabled: () => groupItemProps.value.disabled,
						readOnly: () => groupItemProps.value.readOnly,
						invalid: () => groupItemProps.value.invalid,
					}
				: undefined,
			useMachine: useCheckbox as any,
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<label {...mergedProps.value}>{children}</label>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<label {...mergedProps.value}>{children}</label>
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
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function GroupProvider(props: GroupProviderProps) @{
	let &{ children, value } = props;
	checkboxGroupContext.set(value);
	const localProps = track(
		() => splitProps(props, [
			'value',
		])[1],
	);
	@if (props.render) {
		const Content = createRenderContent(
			track(() => ({ role: 'group', ...localProps.value, ...checkboxGroupAnatomyAttrs })),
			props.render,
		);
		<{Content} />
	} @else {
		<div role="group" {...localProps.value} {...checkboxGroupAnatomyAttrs}>{children}</div>
	}
}
export function Group(props: GroupProps) @{
	let &{ children } = props;
	const group = useCheckboxGroup(props);
	checkboxGroupContext.set(group);
	const localProps = track(
		() => splitProps(props, [
			'defaultValue',
			'value',
			'onValueChange',
			'disabled',
			'invalid',
			'readOnly',
			'name',
			'maxSelectedValues',
		])[1],
	);
	@if (props.render) {
		const Content = createRenderContent(
			track(() => ({ role: 'group', ...localProps.value, ...checkboxGroupAnatomyAttrs })),
			props.render,
		);
		<{Content} />
	} @else {
		<div role="group" {...localProps.value} {...checkboxGroupAnatomyAttrs}>{children}</div>
	}
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getIndicatorProps',
			propKeys: [
				'indeterminate',
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

export type UseCheckboxGroupProps = {
	value?: string[];
	defaultValue?: string[];
	onValueChange?: (value: string[]) => void;
	disabled?: boolean;
	readOnly?: boolean;
	invalid?: boolean;
	name?: string;
	maxSelectedValues?: number;
};

export type CheckboxGroupApi = {
	isChecked(value: string | undefined): boolean;
	value: string[];
	name: string | undefined;
	disabled: boolean | undefined;
	readOnly: boolean | undefined;
	invalid: boolean | undefined;
	setValue(value: string[]): void;
	addValue(value: string): void;
	toggleValue(value: string): void;
	getItemProps(itemProps: { value: string | undefined }): AnyRecord;
};

export function useCheckboxGroup(props: UseCheckboxGroupProps = {}): Tracked<CheckboxGroupApi> {
	const uncontrolledValue = track<string[]>(props.defaultValue ?? []);
	const setValue = (next: string[]) => {
		if (props.value === undefined) uncontrolledValue.value = next;
		props.onValueChange?.(next);
	};
	return track(() => {
		const value = props.value ?? uncontrolledValue.value;
		const disabled = props.disabled;
		const readOnly = props.readOnly;
		const invalid = props.invalid;
		const name = props.name;
		const isAtMax = props.maxSelectedValues != null && value.length >= props.maxSelectedValues;
		const isChecked = (val: string | undefined) => value.some((v) => String(v) === String(val));
		const addValue = (val: string) => {
			if (disabled || readOnly) return;
			if (isChecked(val)) return;
			if (isAtMax) return;
			setValue(value.concat(val));
		};
		const removeValue = (val: string) => {
			if (disabled || readOnly) return;
			setValue(value.filter((v) => String(v) !== String(val)));
		};
		const toggleValue = (val: string) => {
			if (isChecked(val)) removeValue(val);
			else addValue(val);
		};
		return {
			isChecked,
			value,
			name,
			disabled,
			readOnly,
			invalid,
			setValue,
			addValue,
			toggleValue,
			getItemProps(itemProps: { value: string | undefined }) {
				const checked =
					itemProps.value != null ? isChecked(itemProps.value) : undefined;
				return {
					checked,
					onCheckedChange() {
						if (itemProps.value != null) toggleValue(itemProps.value);
					},
					name,
					disabled: disabled || isAtMax && !checked,
					readOnly,
					invalid,
				};
			},
		};
	});
}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'label'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'label'> };
export type RootProviderProps =
	ArkPartProps<'label'> & { value: ReturnType<Hook> } & { render?: RenderProp<'label'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type GroupProviderProps =
	(ArkPartProps<'div'> & { value: Tracked<CheckboxGroupApi> }) & { render?: RenderProp<'div'> };
export type GroupProps =
	(ArkPartProps<'div'> & UseCheckboxGroupProps) & { render?: RenderProp<'div'> };
export type LabelProps =
	(PartProps<'span', Api['getLabelProps']>) & { render?: RenderProp<'span'> };
export type IndicatorProps =
	(PartProps<'div', Api['getIndicatorProps']>) & { render?: RenderProp<'div'> };

export const Checkbox = {
	Root,
	RootProvider,
	HiddenInput,
	Control,
	GroupProvider,
	Group,
	Label,
	Indicator,
	Context,
};
