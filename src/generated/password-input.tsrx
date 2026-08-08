import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePasswordInput } from '../components';
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

type Hook = typeof usePasswordInput;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'autoComplete',
				'defaultVisible',
				'disabled',
				'id',
				'ids',
				'ignorePasswordManagers',
				'invalid',
				'name',
				'onVisibilityChange',
				'readOnly',
				'required',
				'translations',
				'visible',
			],

			useMachine: usePasswordInput as any,
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
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Input(props: InputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function VisibilityTrigger(props: VisibilityTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getVisibilityTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type InputProps = PartProps<'input', Api['getInputProps']>;
export type IndicatorProps = PartProps<'span', Api['getIndicatorProps']>;
export type VisibilityTriggerProps = PartProps<'button', Api['getVisibilityTriggerProps']>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;

export const PasswordInput = {
	Root,
	RootProvider,
	Control,
	Input,
	Indicator,
	VisibilityTrigger,
	Label,
	Context,
};
