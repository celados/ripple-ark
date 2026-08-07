import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useNavigationMenu } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useNavigationMenu;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const navigationMenuViewportProps = new RippleContext<Record<string, any> | null>(null);
const navigationMenuItemProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'nav',
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
});
export const RootProvider = createRootProvider({ context, defaultTag: 'nav' });
export const Viewport = createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewportProps',
	inheritedProps: navigationMenuViewportProps,
});
export const List = createPart({ context, defaultTag: 'div', getter: 'getListProps' });
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });
export const Link = createPart({
	context,
	defaultTag: 'a',
	getter: 'getLinkProps',
	inheritedProps: navigationMenuItemProps,
});
export const ViewportPositioner = createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewportPositionerProps',
	propKeys: [
		'align',
	],
	provideProps: navigationMenuViewportProps,
});
export const Content = createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
	inheritedProps: navigationMenuItemProps,
});
export const Trigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	inheritedProps: navigationMenuItemProps,
});
export const ItemIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: navigationMenuItemProps,
});
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	provideProps: navigationMenuItemProps,
});
export const Arrow = createPart({ context, defaultTag: 'div', getter: 'getArrowProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ViewportProps = ArkPartProps;
export type ListProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type LinkProps = ArkPartProps;
export type ViewportPositionerProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ItemIndicatorProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ArrowProps = ArkPartProps;

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
