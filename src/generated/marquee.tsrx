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

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
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
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Edge = createPart({
	context,
	defaultTag: 'div',
	getter: 'getEdgeProps',
	propKeys: [
		'side',
	],
});
export const Item = createPart({ context, defaultTag: 'div', getter: 'getItemProps' });
export const Viewport = createPart({ context, defaultTag: 'div', getter: 'getViewportProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type EdgeProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ViewportProps = ArkPartProps;
export type ContentProps = ArkPartProps;

export const Marquee = { Root, RootProvider, Edge, Item, Viewport, Content, Context };
