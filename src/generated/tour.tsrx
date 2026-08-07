import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTour } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useTour;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	configKeys: [],

	useMachine: useTour as any,
});
export const RootProvider = createRootProvider({ context });
export const Title = createPart({ context, defaultTag: 'h2', getter: 'getTitleProps' });
export const Spotlight = createPart({ context, defaultTag: 'div', getter: 'getSpotlightProps' });
export const ActionTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getActionTriggerProps',
	propKeys: [
		'action',
	],
});
export const ProgressText = createPart({
	context,
	defaultTag: 'div',
	getter: 'getProgressTextProps',
});
export const CloseTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getCloseTriggerProps',
});
export const Arrow = createPart({ context, defaultTag: 'div', getter: 'getArrowProps' });
export const ArrowTip = createPart({ context, defaultTag: 'div', getter: 'getArrowTipProps' });
export const Backdrop = createPart({ context, defaultTag: 'div', getter: 'getBackdropProps' });
export const Description = createPart({
	context,
	defaultTag: 'div',
	getter: 'getDescriptionProps',
});
export const Control = createPart({ context, defaultTag: 'div' });
export const Positioner = createPart({ context, defaultTag: 'div', getter: 'getPositionerProps' });
export const Content = createPart({ context, defaultTag: 'div', getter: 'getContentProps' });

export function Actions(props: { children: (actions: Tracked<AnyRecord[]>) => Children }) @{
	const api = context.get();
	if (!api) throw new Error('Tour.Actions must be rendered inside Tour.Root');
	const actions = track(() => api.value.step?.actions ?? []);
	const render = props.children;
	{
		render(actions);
	}
}
export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type TitleProps = ArkPartProps;
export type SpotlightProps = ArkPartProps;
export type ActionTriggerProps = ArkPartProps;
export type ProgressTextProps = ArkPartProps;
export type CloseTriggerProps = ArkPartProps;
export type ArrowProps = ArkPartProps;
export type ArrowTipProps = ArkPartProps;
export type BackdropProps = ArkPartProps;
export type DescriptionProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type PositionerProps = ArkPartProps;
export type ContentProps = ArkPartProps;

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
