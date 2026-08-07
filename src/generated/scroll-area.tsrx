import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useScrollArea } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useScrollArea;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'id',
		'ids',
	],

	useMachine: useScrollArea as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Thumb = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getThumbProps',
});
export const Scrollbar = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getScrollbarProps',
	propKeys: [
		'orientation',
	],
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const Viewport = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getViewportProps',
});
export const Corner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getCornerProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ThumbProps = ArkPartProps;
export type ScrollbarProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type ViewportProps = ArkPartProps;
export type CornerProps = ArkPartProps;

export const ScrollArea = {
	Root,
	RootProvider,
	Thumb,
	Scrollbar,
	Content,
	Viewport,
	Corner,
	Context,
};
