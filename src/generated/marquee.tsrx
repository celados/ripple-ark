import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useMarquee } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useMarquee;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'autoFill',
		'defaultPaused',
		'delay',
		'id',
		'ids',
		'loopCount',
		'onComplete',
		'onLoopComplete',
		'onPauseChange',
		'paused',
		'pauseOnInteraction',
		'reverse',
		'side',
		'spacing',
		'speed',
		'translations',
	],

	useMachine: useMarquee as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Edge = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getEdgeProps',
	propKeys: [
		'side',
	],
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
});
export const Viewport = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewportProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type EdgeProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ViewportProps = ArkPartProps;
export type ContentProps = ArkPartProps;

export const Marquee = { Root, RootProvider, Edge, Item, Viewport, Content, Context };
