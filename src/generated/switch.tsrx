import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSwitch } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	createRenderContent,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useSwitch;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
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
export function Thumb(props: ThumbProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getThumbProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'label'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'label'> };
export type RootProviderProps =
	ArkPartProps<'label'> & { value: ReturnType<Hook> } & { render?: RenderProp<'label'> };
export type ControlProps =
	(PartProps<'span', Api['getControlProps']>) & { render?: RenderProp<'span'> };
export type LabelProps =
	(PartProps<'span', Api['getLabelProps']>) & { render?: RenderProp<'span'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type ThumbProps =
	(PartProps<'span', Api['getThumbProps']>) & { render?: RenderProp<'span'> };

export const Switch = { Root, RootProvider, Control, Label, HiddenInput, Thumb, Context };
