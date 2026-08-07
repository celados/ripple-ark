import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { usePagination } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof usePagination;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'nav',
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
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'nav' });
export const NextTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getNextTriggerProps',
});
export const FirstTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getFirstTriggerProps',
});
export const LastTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getLastTriggerProps',
});
export const PrevTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getPrevTriggerProps',
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getItemProps',
	propKeys: [
		'value',
		'type',
	],
});
export const Ellipsis = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getEllipsisProps',
	propKeys: [
		'index',
	],
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type NextTriggerProps = ArkPartProps;
export type FirstTriggerProps = ArkPartProps;
export type LastTriggerProps = ArkPartProps;
export type PrevTriggerProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type EllipsisProps = ArkPartProps;

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
