import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useMarquee } from '../components';
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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Edge(props: EdgeProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getEdgeProps',
			propKeys: [
				'side',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getItemProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewportProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type EdgeProps = PartProps<'div', Api['getEdgeProps']>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ViewportProps = PartProps<'div', Api['getViewportProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;

export const Marquee = { Root, RootProvider, Edge, Item, Viewport, Content, Context };
