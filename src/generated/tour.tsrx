import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTour } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootPresence,
	usePresenceState,
	createRenderContent,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
	type PresenceState,
} from '../binding-runtime.tsrx';

type Hook = typeof useTour;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	context.set(props.tour);
	useRootPresence(presenceContext, () => props.tour.value.open, props);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	context.set(props.tour);
	useRootPresence(presenceContext, () => props.tour.value.open, props);
	<>
		{children}
	</>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<h2 {...mergedProps.value}>{children || api.value.step?.title}</h2>
	}
}
export function Spotlight(props: SpotlightProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSpotlightProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ActionTrigger(props: ActionTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getActionTriggerProps',
			propKeys: [
				'action',
			],
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children || (props as any).action?.label}</button>
	}
}
export function ProgressText(props: ProgressTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const mergedProps = usePartProps({ context, getter: 'getProgressTextProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children || api.value.getProgressText()}</div>
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
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Backdrop(props: BackdropProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getBackdropProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	const api = context.get()!;
	const mergedProps = usePartProps({ context, getter: 'getDescriptionProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children || api.value.step?.description}</div>
	}
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
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
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}

export function Actions(props: { render: (actions: Tracked<AnyRecord[]>) => Children }) @{
	const api = context.get();
	if (!api) throw new Error('Tour.Actions must be rendered inside Tour.Root');
	const actions = track(() => api.value.step?.actions ?? []);
	const Content = () => props.render(actions);
	<{Content} />
}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	{ tour: ReturnType<typeof useTour> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	} & ComponentProps;
export type RootProviderProps =
	{ tour: ReturnType<typeof useTour> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	} & ComponentProps;
export type TitleProps = (PartProps<'h2', Api['getTitleProps']>) & { render?: RenderProp<'h2'> };
export type SpotlightProps =
	(PartProps<'div', Api['getSpotlightProps']>) & { render?: RenderProp<'div'> };
export type ActionTriggerProps =
	(PartProps<'button', Api['getActionTriggerProps']>) & { render?: RenderProp<'button'> };
export type ProgressTextProps =
	(PartProps<'div', Api['getProgressTextProps']>) & { render?: RenderProp<'div'> };
export type CloseTriggerProps =
	(PartProps<'button', Api['getCloseTriggerProps']>) & { render?: RenderProp<'button'> };
export type ArrowProps = (PartProps<'div', Api['getArrowProps']>) & { render?: RenderProp<'div'> };
export type ArrowTipProps =
	(PartProps<'div', Api['getArrowTipProps']>) & { render?: RenderProp<'div'> };
export type BackdropProps =
	(PartProps<'div', Api['getBackdropProps']>) & { render?: RenderProp<'div'> };
export type DescriptionProps =
	(PartProps<'div', Api['getDescriptionProps']>) & { render?: RenderProp<'div'> };
export type ControlProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };

export const Tour = {
	Root,
	RootProvider,
	Title,
	Spotlight,
	ActionTrigger,
	ProgressText,
	CloseTrigger,
	Arrow,
	ArrowTip,
	Backdrop,
	Description,
	Control,
	Positioner,
	Content,
	Actions,
	Context,
};
