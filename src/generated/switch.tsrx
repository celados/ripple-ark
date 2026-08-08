import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSwitch } from '../components';
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

type Hook = typeof useSwitch;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
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
				'label',
				'name',
				'onCheckedChange',
				'readOnly',
				'required',
				'value',
			],

			useMachine: useSwitch as any,
		},
		props,
	);
	<label {...mergedProps.value}>{children}</label>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function HiddenInput(props: HiddenInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Thumb(props: ThumbProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getThumbProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'label'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'label'> & { value: ReturnType<Hook> };
export type ControlProps = PartProps<'span', Api['getControlProps']>;
export type LabelProps = PartProps<'span', Api['getLabelProps']>;
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;
export type ThumbProps = PartProps<'span', Api['getThumbProps']>;

export const Switch = { Root, RootProvider, Control, Label, HiddenInput, Thumb, Context };
