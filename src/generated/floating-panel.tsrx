import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useFloatingPanel } from '../components';
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

type Hook = typeof useFloatingPanel;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
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
		},
		props,
	);
	{
		children;
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	{
		children;
	}
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	<h2 {...mergedProps.value}>{children}</h2>
}
export function ResizeTrigger(props: ResizeTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getResizeTriggerProps',
			propKeys: [
				'axis',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function DragTrigger(props: DragTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDragTriggerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function StageTrigger(props: StageTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getStageTriggerProps',
			propKeys: [
				'stage',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Header(props: HeaderProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHeaderProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Body(props: BodyProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getBodyProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCloseTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ComponentProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ComponentProps & { value: ReturnType<Hook> };
export type TitleProps = PartProps<'h2', Api['getTitleProps']>;
export type ResizeTriggerProps = PartProps<'div', Api['getResizeTriggerProps']>;
export type DragTriggerProps = PartProps<'div', Api['getDragTriggerProps']>;
export type StageTriggerProps = PartProps<'button', Api['getStageTriggerProps']>;
export type HeaderProps = PartProps<'div', Api['getHeaderProps']>;
export type BodyProps = PartProps<'div', Api['getBodyProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type CloseTriggerProps = PartProps<'button', Api['getCloseTriggerProps']>;

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
