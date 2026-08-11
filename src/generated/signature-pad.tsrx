import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSignaturePad } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useSignaturePad;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'id',
				'ids',
				'defaultPaths',
				'drawing',
				'disabled',
				'readOnly',
				'name',
				'onDraw',
				'onDrawEnd',
				'paths',
				'readOnly',
				'required',
				'translations',
			],

			useMachine: useSignaturePad as any,
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
export function Guide(props: GuideProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getGuideProps' }} of={props}>{children}</Part>
}
export function HiddenInput(props: HiddenInputProps) @{
	<Part
		tag="input"
		options={{
			context,
			getter: 'getHiddenInputProps',
			propKeys: [
				'value',
			],
		}}
		of={props}
	/>
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
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Segment(props: SegmentProps) @{
	let &{ children } = props;
	const api = context.get();
	if (!api) throw new Error('SignaturePad.Segment must be rendered inside SignaturePad.Root');
	const mergedProps = usePartProps({ context, getter: 'getSegmentProps' }, props);
	<Part tag="svg" merged={mergedProps} of={props}>
		<title>Signature</title>
		@for (const path of api.value.paths) {
			<path {...api.value.getSegmentPathProps({ path })} />
		}
		@if (api.value.currentPath) {
			<path {...api.value.getSegmentPathProps({ path: api.value.currentPath })} />
		}
		{children}
	</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type GuideProps = (PartProps<'div', Api['getGuideProps']>) & { render?: RenderProp<'div'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type ClearTriggerProps =
	(PartProps<'button', Api['getClearTriggerProps']>) & { render?: RenderProp<'button'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type SegmentProps =
	(PartProps<'svg', Api['getSegmentProps']>) & { render?: RenderProp<'svg'> };

export const SignaturePad = {
	Root,
	RootProvider,
	Guide,
	HiddenInput,
	Label,
	ClearTrigger,
	Control,
	Segment,
	Context,
};
