import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSplitter } from '../components';
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

type Hook = typeof useSplitter;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const splitterResizeTriggerProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'defaultSize',
				'id',
				'ids',
				'keyboardResizeBy',
				'nonce',
				'onCollapse',
				'onExpand',
				'onResize',
				'onResizeEnd',
				'onResizeStart',
				'orientation',
				'panels',
				'size',
				'registry',
			],

			useMachine: useSplitter as any,
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
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ResizeTriggerIndicator(props: ResizeTriggerIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, inheritedProps: splitterResizeTriggerProps }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ResizeTrigger(props: ResizeTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getResizeTriggerProps',
			propKeys: [
				'disabled',
				'id',
			],
			provideProps: splitterResizeTriggerProps,
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Panel(props: PanelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getPanelProps',
			propKeys: [
				'id',
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

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ResizeTriggerIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ResizeTriggerProps =
	(PartProps<'button', Api['getResizeTriggerProps']>) & { render?: RenderProp<'button'> };
export type PanelProps = (PartProps<'div', Api['getPanelProps']>) & { render?: RenderProp<'div'> };

export const Splitter = {
	Root,
	RootProvider,
	ResizeTriggerIndicator,
	ResizeTrigger,
	Panel,
	Context,
};
