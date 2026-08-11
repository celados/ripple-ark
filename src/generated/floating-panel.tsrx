import {
	Context as RippleContext,
	effect,
	track,
	createRefKey,
	type Children,
	type Tracked,
} from 'ripple';
import { mergeProps } from '@zag-js/core';
import { useFloatingPanel } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	usePresenceState,
	PRESENCE_KEYS,
	createRenderContent,
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
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<h2 {...mergedProps.value}>{children}</h2>
	}
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function DragTrigger(props: DragTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDragTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Header(props: HeaderProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getHeaderProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Body(props: BodyProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getBodyProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const presence = usePresenceState(presenceContext);
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	@if (!presence.value.unmounted) {
		@if (props.render) {
			const Content = createRenderContent(mergedProps, props.render);
			<{Content} />
		} @else {
			<div {...mergedProps.value}>{children}</div>
		}
	}
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Content(props: ContentProps) @{
	let &{ children, ref } = props;
	const presence = usePresenceState(presenceContext);
	const presenceRefKey = createRefKey();
	let applyPresenceRef = (node: any) => {
		presence.value.setNode(node);
		if (typeof ref === 'function') ref(node);
	};
	const mergedProps = usePartProps(
		{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] },
		props,
	);
	@if (!presence.value.unmounted) {
		@if (props.render) {
			const Content = createRenderContent(
				track(() => ({ ...mergedProps.value, [presenceRefKey]: applyPresenceRef })),
				props.render,
			);
			<{Content} />
		} @else {
			<div {...mergedProps.value} ref={applyPresenceRef}>{children}</div>
		}
	}
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCloseTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
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
