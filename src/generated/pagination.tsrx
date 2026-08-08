import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePagination } from '../components';
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
	<nav {...mergedProps.value}>{children}</nav>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<nav {...mergedProps.value}>{children}</nav>
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getNextTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function FirstTrigger(props: FirstTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getFirstTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function LastTrigger(props: LastTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLastTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPrevTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
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
	<button {...mergedProps.value}>{children}</button>
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
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'nav'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'nav'> & { value: ReturnType<Hook> };
export type NextTriggerProps = PartProps<'button', Api['getNextTriggerProps']>;
export type FirstTriggerProps = PartProps<'button', Api['getFirstTriggerProps']>;
export type LastTriggerProps = PartProps<'button', Api['getLastTriggerProps']>;
export type PrevTriggerProps = PartProps<'button', Api['getPrevTriggerProps']>;
export type ItemProps = PartProps<'button', Api['getItemProps']>;
export type EllipsisProps = PartProps<'div', Api['getEllipsisProps']>;

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
