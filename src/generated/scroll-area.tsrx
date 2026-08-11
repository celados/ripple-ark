import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useScrollArea } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Thumb(props: ThumbProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getThumbProps' }} of={props}>{children}</Part>
}
export function Scrollbar(props: ScrollbarProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getScrollbarProps',
			propKeys: [
				'orientation',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getContentProps' }} of={props}>{children}</Part>
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getViewportProps' }} of={props}>{children}</Part>
}
export function Corner(props: CornerProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getCornerProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ThumbProps = (PartProps<'div', Api['getThumbProps']>) & { render?: RenderProp<'div'> };
export type ScrollbarProps =
	(PartProps<'div', Api['getScrollbarProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type ViewportProps =
	(PartProps<'div', Api['getViewportProps']>) & { render?: RenderProp<'div'> };
export type CornerProps =
	(PartProps<'div', Api['getCornerProps']>) & { render?: RenderProp<'div'> };

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
