import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSplitter } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function ResizeTriggerIndicator(props: ResizeTriggerIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, inheritedProps: splitterResizeTriggerProps }}
		of={props}
	>{children}</Part>
}
export function ResizeTrigger(props: ResizeTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getResizeTriggerProps',
			propKeys: [
				'disabled',
				'id',
			],
			provideProps: splitterResizeTriggerProps,
		}}
		of={props}
	>{children}</Part>
}
export function Panel(props: PanelProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getPanelProps',
			propKeys: [
				'id',
			],
		}}
		of={props}
	>{children}</Part>
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
