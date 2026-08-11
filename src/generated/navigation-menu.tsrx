import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNavigationMenu } from '../components';
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

type Hook = typeof useNavigationMenu;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const navigationMenuViewportProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);
const navigationMenuItemProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
	<Part tag="nav" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="nav" merged={mergedProps} of={props}>{children}</Part>
}
export function Viewport(props: ViewportProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getViewportProps', inheritedProps: navigationMenuViewportProps }}
		of={props}
	>{children}</Part>
}
export function List(props: ListProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getListProps' }} of={props}>{children}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getIndicatorProps' }} of={props}>{children}</Part>
}
export function Link(props: LinkProps) @{
	let &{ children } = props;
	<Part
		tag="a"
		options={{ context, getter: 'getLinkProps', inheritedProps: navigationMenuItemProps }}
		of={props}
	>{children}</Part>
}
export function ViewportPositioner(props: ViewportPositionerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getViewportPositionerProps',
			propKeys: [
				'align',
			],
			provideProps: navigationMenuViewportProps,
		}}
		of={props}
	>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getContentProps', inheritedProps: navigationMenuItemProps }}
		of={props}
	>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getTriggerProps', inheritedProps: navigationMenuItemProps }}
		of={props}
	>{children}</Part>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemIndicatorProps', inheritedProps: navigationMenuItemProps }}
		of={props}
	>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemProps', provideProps: navigationMenuItemProps }}
		of={props}
	>{children}</Part>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'nav'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'nav'> };
export type RootProviderProps =
	ArkPartProps<'nav'> & { value: ReturnType<Hook> } & { render?: RenderProp<'nav'> };
export type ViewportProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ListProps = (PartProps<'div', Api['getListProps']>) & { render?: RenderProp<'div'> };
export type IndicatorProps =
	(PartProps<'div', Api['getIndicatorProps']>) & { render?: RenderProp<'div'> };
export type LinkProps = (ArkPartProps<'a'>) & { render?: RenderProp<'a'> };
export type ViewportPositionerProps =
	(PartProps<'div', Api['getViewportPositionerProps']>) & { render?: RenderProp<'div'> };
export type ContentProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type TriggerProps = (ArkPartProps<'button'>) & { render?: RenderProp<'button'> };
export type ItemIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ArrowProps = (PartProps<'div', Api['getArrowProps']>) & { render?: RenderProp<'div'> };

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
