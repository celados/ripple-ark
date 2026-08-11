import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { mergeProps } from '@zag-js/core';
import { useFloatingPanel } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	usePresenceState,
	PRESENCE_KEYS,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
	type PresenceState,
} from '../binding-runtime.tsrx';

type Hook = typeof useFloatingPanel;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	// Rootless upstream: the call runs for its machine/context side effects only.
	useRootProps(
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
			omitKeys: PRESENCE_KEYS,

			useMachine: useFloatingPanel as any,
		},
		props,
	);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	<Part tag="h2" options={{ context, getter: 'getTitleProps' }} of={props}>{children}</Part>
}
export function ResizeTrigger(props: ResizeTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getResizeTriggerProps',
			propKeys: [
				'axis',
			],
		}}
		of={props}
	>{children}</Part>
}
export function DragTrigger(props: DragTriggerProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getDragTriggerProps' }} of={props}>{children}</Part>
}
export function StageTrigger(props: StageTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getStageTriggerProps',
			propKeys: [
				'stage',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Header(props: HeaderProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getHeaderProps' }} of={props}>{children}</Part>
}
export function Body(props: BodyProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getBodyProps' }} of={props}>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getPositionerProps' }}
		presence={presenceContext}
		gate
		of={props}
	>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children, render: _render, ...localProps } = props;
	const api = context.get();
	if (
		!api
	) throw new Error('FloatingPanel.Trigger must be rendered inside FloatingPanel.Root or RootProvider');
	const presence = usePresenceState(presenceContext);
	const mergedProps = track(() => {
		const triggerProps = api.value.getTriggerProps();
		return mergeProps(
			{
				...triggerProps,
				'aria-controls': presence.value.unmounted ? undefined : triggerProps['aria-controls'],
			},
			localProps,
		);
	});
	<Part tag="button" merged={mergedProps} of={props}>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] }}
		presence={presenceContext}
		gate
		composeRef
		of={props}
	>{children}</Part>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getCloseTriggerProps' }}
		of={props}
	>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ComponentProps & NonNullable<Parameters<Hook>[0]> & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type RootProviderProps =
	ComponentProps & { value: ReturnType<Hook> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type TitleProps = (PartProps<'h2', Api['getTitleProps']>) & { render?: RenderProp<'h2'> };
export type ResizeTriggerProps =
	(PartProps<'div', Api['getResizeTriggerProps']>) & { render?: RenderProp<'div'> };
export type DragTriggerProps =
	(PartProps<'div', Api['getDragTriggerProps']>) & { render?: RenderProp<'div'> };
export type StageTriggerProps =
	(PartProps<'button', Api['getStageTriggerProps']>) & { render?: RenderProp<'button'> };
export type HeaderProps =
	(PartProps<'div', Api['getHeaderProps']>) & { render?: RenderProp<'div'> };
export type BodyProps = (PartProps<'div', Api['getBodyProps']>) & { render?: RenderProp<'div'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type CloseTriggerProps =
	(PartProps<'button', Api['getCloseTriggerProps']>) & { render?: RenderProp<'button'> };

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
