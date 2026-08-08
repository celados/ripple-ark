import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useScrollArea } from '../components';
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

type Hook = typeof useScrollArea;
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
			],

			useMachine: useScrollArea as any,
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
export function Thumb(props: ThumbProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getThumbProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Scrollbar(props: ScrollbarProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getScrollbarProps',
			propKeys: [
				'orientation',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getViewportProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Corner(props: CornerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCornerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ThumbProps = PartProps<'div', Api['getThumbProps']>;
export type ScrollbarProps = PartProps<'div', Api['getScrollbarProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type ViewportProps = PartProps<'div', Api['getViewportProps']>;
export type CornerProps = PartProps<'div', Api['getCornerProps']>;

export const ScrollArea = {
	Root,
	RootProvider,
	Thumb,
	Scrollbar,
	Content,
	Viewport,
	Corner,
	Context,
};
