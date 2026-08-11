import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useMarquee } from '../components';
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

type Hook = typeof useMarquee;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'autoFill',
				'defaultPaused',
				'delay',
				'id',
				'ids',
				'loopCount',
				'onComplete',
				'onLoopComplete',
				'onPauseChange',
				'paused',
				'pauseOnInteraction',
				'reverse',
				'side',
				'spacing',
				'speed',
				'translations',
			],

			useMachine: useMarquee as any,
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
export function Edge(props: EdgeProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getEdgeProps',
			propKeys: [
				'side',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getItemProps' }} of={props}>{children}</Part>
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getViewportProps' }} of={props}>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getContentProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type EdgeProps = (PartProps<'div', Api['getEdgeProps']>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ViewportProps =
	(PartProps<'div', Api['getViewportProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };

export const Marquee = { Root, RootProvider, Edge, Item, Viewport, Content, Context };
