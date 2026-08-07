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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const navigationMenuViewportProps = /*#__PURE__*/ new RippleContext<
	Record<string, any> | null
>(null);
const navigationMenuItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'nav' });
export const Viewport = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewportProps',
	inheritedProps: navigationMenuViewportProps,
});
export const List = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getListProps',
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
});
export const Link = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'a',
	getter: 'getLinkProps',
	inheritedProps: navigationMenuItemProps,
});
export const ViewportPositioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewportPositionerProps',
	propKeys: [
		'align',
	],
	provideProps: navigationMenuViewportProps,
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
	inheritedProps: navigationMenuItemProps,
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	inheritedProps: navigationMenuItemProps,
});
export const ItemIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: navigationMenuItemProps,
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	provideProps: navigationMenuItemProps,
});
export const Arrow = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

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
