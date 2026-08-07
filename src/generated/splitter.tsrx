import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSplitter } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useSplitter;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const splitterResizeTriggerProps = /*#__PURE__*/ new RippleContext<
	Record<string, any> | null
>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'defaultSize',
		'id',
		'ids',
		'keyboardResizeBy',
		'nonce',
		'onCollapse',
		'onExpand',
		'onResize',
		'onResizeEnd',
		'onResizeStart',
		'orientation',
		'panels',
		'size',
		'registry',
	],

	useMachine: useSplitter as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const ResizeTriggerIndicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	inheritedProps: splitterResizeTriggerProps,
});
export const ResizeTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getResizeTriggerProps',
	propKeys: [
		'disabled',
		'id',
	],
	provideProps: splitterResizeTriggerProps,
});
export const Panel = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPanelProps',
	propKeys: [
		'id',
	],
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ResizeTriggerIndicatorProps = ArkPartProps;
export type ResizeTriggerProps = ArkPartProps;
export type PanelProps = ArkPartProps;

export const Splitter = {
	Root,
	RootProvider,
	ResizeTriggerIndicator,
	ResizeTrigger,
	Panel,
	Context,
};
