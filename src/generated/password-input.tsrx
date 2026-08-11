import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePasswordInput } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Input(props: InputProps) @{
	<Part tag="input" options={{ context, getter: 'getInputProps' }} of={props} />
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context, getter: 'getIndicatorProps' }} of={props}>{children}</Part>
}
export function VisibilityTrigger(props: VisibilityTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getVisibilityTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type InputProps =
	(PartProps<'input', Api['getInputProps']>) & { render?: RenderProp<'input'> };
export type IndicatorProps =
	(PartProps<'span', Api['getIndicatorProps']>) & { render?: RenderProp<'span'> };
export type VisibilityTriggerProps =
	(PartProps<'button', Api['getVisibilityTriggerProps']>) & { render?: RenderProp<'button'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };

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
