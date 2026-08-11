import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTour } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootPresence,
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
	<Part tag="h2" options={{ context, getter: 'getTitleProps' }} of={props}>
		{children || api.value.step?.title}
	</Part>
}
export function Spotlight(props: SpotlightProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getSpotlightProps' }} of={props}>{children}</Part>
}
export function ActionTrigger(props: ActionTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getActionTriggerProps',
			propKeys: [
				'action',
			],
		}}
		of={props}
	>
		{children || (props as any).action?.label}
	</Part>
}
export function ProgressText(props: ProgressTextProps) @{
	let &{ children } = props;
	const api = context.get()!;
	<Part tag="div" options={{ context, getter: 'getProgressTextProps' }} of={props}>
		{children || api.value.getProgressText()}
	</Part>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getCloseTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowProps' }} of={props}>{children}</Part>
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowTipProps' }} of={props}>{children}</Part>
}
export function Backdrop(props: BackdropProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getBackdropProps' }} of={props}>{children}</Part>
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	const api = context.get()!;
	<Part tag="div" options={{ context, getter: 'getDescriptionProps' }} of={props}>
		{children || api.value.step?.description}
	</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context }} of={props}>{children}</Part>
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
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getContentProps' }} of={props}>{children}</Part>
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
