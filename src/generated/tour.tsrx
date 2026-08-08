import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTour } from '../components';
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

type Hook = typeof useTour;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [],

			useMachine: useTour as any,
		},
		props,
	);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<>
		{children}
	</>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	<h2 {...mergedProps.value}>{children}</h2>
}
export function Spotlight(props: SpotlightProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getSpotlightProps' }, props);
	<div {...mergedProps.value}>{children}</div>
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
	<button {...mergedProps.value}>{children}</button>
}
export function ProgressText(props: ProgressTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getProgressTextProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCloseTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getArrowTipProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Backdrop(props: BackdropProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getBackdropProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDescriptionProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export function Actions(props: { render: (actions: Tracked<AnyRecord[]>) => Children }) @{
	const api = context.get();
	if (!api) throw new Error('Tour.Actions must be rendered inside Tour.Root');
	const actions = track(() => api.value.step?.actions ?? []);
	const Content = () => props.render(actions);
	<{Content} />
}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ComponentProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ComponentProps & { value: ReturnType<Hook> };
export type TitleProps = PartProps<'h2', Api['getTitleProps']>;
export type SpotlightProps = PartProps<'div', Api['getSpotlightProps']>;
export type ActionTriggerProps = PartProps<'button', Api['getActionTriggerProps']>;
export type ProgressTextProps = PartProps<'div', Api['getProgressTextProps']>;
export type CloseTriggerProps = PartProps<'button', Api['getCloseTriggerProps']>;
export type ArrowProps = PartProps<'div', Api['getArrowProps']>;
export type ArrowTipProps = PartProps<'div', Api['getArrowTipProps']>;
export type BackdropProps = PartProps<'div', Api['getBackdropProps']>;
export type DescriptionProps = PartProps<'div', Api['getDescriptionProps']>;
export type ControlProps = ArkPartProps<'div'>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;

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
