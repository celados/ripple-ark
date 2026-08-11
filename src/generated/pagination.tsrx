import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePagination } from '../components';
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

type Hook = typeof usePagination;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'boundaryCount',
				'count',
				'defaultPage',
				'defaultPageSize',
				'getPageUrl',
				'id',
				'ids',
				'onPageChange',
				'onPageSizeChange',
				'page',
				'pageSize',
				'siblingCount',
				'translations',
				'type',
			],

			useMachine: usePagination as any,
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<nav {...mergedProps.value}>{children}</nav>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<nav {...mergedProps.value}>{children}</nav>
	}
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getNextTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function FirstTrigger(props: FirstTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getFirstTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function LastTrigger(props: LastTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLastTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPrevTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'value',
				'type',
			],
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
export function Ellipsis(props: EllipsisProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getEllipsisProps',
			propKeys: [
				'index',
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
	ArkPartProps<'nav'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'nav'> };
export type RootProviderProps =
	ArkPartProps<'nav'> & { value: ReturnType<Hook> } & { render?: RenderProp<'nav'> };
export type NextTriggerProps =
	(PartProps<'button', Api['getNextTriggerProps']>) & { render?: RenderProp<'button'> };
export type FirstTriggerProps =
	(PartProps<'button', Api['getFirstTriggerProps']>) & { render?: RenderProp<'button'> };
export type LastTriggerProps =
	(PartProps<'button', Api['getLastTriggerProps']>) & { render?: RenderProp<'button'> };
export type PrevTriggerProps =
	(PartProps<'button', Api['getPrevTriggerProps']>) & { render?: RenderProp<'button'> };
export type ItemProps =
	(PartProps<'button', Api['getItemProps']>) & { render?: RenderProp<'button'> };
export type EllipsisProps =
	(PartProps<'div', Api['getEllipsisProps']>) & { render?: RenderProp<'div'> };

export const Pagination = {
	Root,
	RootProvider,
	NextTrigger,
	FirstTrigger,
	LastTrigger,
	PrevTrigger,
	Item,
	Ellipsis,
	Context,
};
