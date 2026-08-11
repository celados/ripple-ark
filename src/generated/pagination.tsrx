import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePagination } from '../components';
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
	<Part tag="nav" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="nav" merged={mergedProps} of={props}>{children}</Part>
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getNextTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function FirstTrigger(props: FirstTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getFirstTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function LastTrigger(props: LastTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getLastTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getPrevTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getItemProps',
			propKeys: [
				'value',
				'type',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Ellipsis(props: EllipsisProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getEllipsisProps',
			propKeys: [
				'index',
			],
		}}
		of={props}
	>{children}</Part>
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
