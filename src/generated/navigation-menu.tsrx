import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNavigationMenu } from '../components';
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

type Hook = typeof useNavigationMenu;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const navigationMenuViewportProps = /*#__PURE__*/ new RippleContext<
	Record<string, any> | null
>(null);
const navigationMenuItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'closeDelay',
				'defaultValue',
				'disableClickTrigger',
				'disableHoverTrigger',
				'disablePointerLeaveClose',
				'id',
				'ids',
				'onValueChange',
				'openDelay',
				'orientation',
				'translations',
				'value',
			],

			useMachine: useNavigationMenu as any,
		},
		props,
	);
	<nav {...mergedProps.value}>{children}</nav>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<nav {...mergedProps.value}>{children}</nav>
}
export function Viewport(props: ViewportProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getViewportProps', inheritedProps: navigationMenuViewportProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function List(props: ListProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getListProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Indicator(props: IndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Link(props: LinkProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getLinkProps', inheritedProps: navigationMenuItemProps },
		props,
	);
	<a {...mergedProps.value}>{children}</a>
}
export function ViewportPositioner(props: ViewportPositionerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getViewportPositionerProps',
			propKeys: [
				'align',
			],
			provideProps: navigationMenuViewportProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getContentProps', inheritedProps: navigationMenuItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getTriggerProps', inheritedProps: navigationMenuItemProps },
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: navigationMenuItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemProps', provideProps: navigationMenuItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Arrow(props: ArrowProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'nav'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'nav'> & { value: ReturnType<Hook> };
export type ViewportProps = ArkPartProps<'div'>;
export type ListProps = PartProps<'div', Api['getListProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;
export type LinkProps = ArkPartProps<'a'>;
export type ViewportPositionerProps = PartProps<'div', Api['getViewportPositionerProps']>;
export type ContentProps = ArkPartProps<'div'>;
export type TriggerProps = ArkPartProps<'button'>;
export type ItemIndicatorProps = ArkPartProps<'div'>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ArrowProps = PartProps<'div', Api['getArrowProps']>;

export const NavigationMenu = {
	Root,
	RootProvider,
	Viewport,
	List,
	Indicator,
	Link,
	ViewportPositioner,
	Content,
	Trigger,
	ItemIndicator,
	Item,
	Arrow,
	Context,
};
