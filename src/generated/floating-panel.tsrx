import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useFloatingPanel } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useFloatingPanel;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	configKeys: [
		'allowOverflow',
		'closeOnEscape',
		'defaultOpen',
		'defaultPosition',
		'defaultSize',
		'dir',
		'disabled',
		'draggable',
		'getAnchorPosition',
		'getBoundaryEl',
		'gridSize',
		'finalFocusEl',
		'id',
		'ids',
		'initialFocusEl',
		'lockAspectRatio',
		'maxSize',
		'minSize',
		'onOpenChange',
		'onPositionChange',
		'onPositionChangeEnd',
		'onSizeChange',
		'onSizeChangeEnd',
		'onStageChange',
		'open',
		'persistRect',
		'position',
		'resizable',
		'restoreFocus',
		'size',
		'strategy',
		'translations',
	],

	useMachine: useFloatingPanel as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context });
export const Title = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'h2',
	getter: 'getTitleProps',
});
export const ResizeTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getResizeTriggerProps',
	propKeys: [
		'axis',
	],
});
export const DragTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getDragTriggerProps',
});
export const StageTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getStageTriggerProps',
	propKeys: [
		'stage',
	],
});
export const Header = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getHeaderProps',
});
export const Body = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getBodyProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const CloseTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getCloseTriggerProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type TitleProps = ArkPartProps;
export type ResizeTriggerProps = ArkPartProps;
export type DragTriggerProps = ArkPartProps;
export type StageTriggerProps = ArkPartProps;
export type HeaderProps = ArkPartProps;
export type BodyProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type TriggerProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type CloseTriggerProps = ArkPartProps;

export const FloatingPanel = {
	Root,
	RootProvider,
	Title,
	ResizeTrigger,
	DragTrigger,
	StageTrigger,
	Header,
	Body,
	Control,
	Positioner,
	Trigger,
	Content,
	CloseTrigger,
	Context,
};
