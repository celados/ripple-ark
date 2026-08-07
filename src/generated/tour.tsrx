import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTour } from '../components';
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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	configKeys: [],

	useMachine: useTour as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context });
export const Title = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'h2',
	getter: 'getTitleProps',
});
export const Spotlight = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSpotlightProps',
});
export const ActionTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getActionTriggerProps',
	propKeys: [
		'action',
	],
});
export const ProgressText = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getProgressTextProps',
});
export const CloseTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getCloseTriggerProps',
});
export const Arrow = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowProps',
});
export const ArrowTip = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getArrowTipProps',
});
export const Backdrop = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getBackdropProps',
});
export const Description = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getDescriptionProps',
});
export const Control = /*#__PURE__*/ createPart({ context, defaultTag: 'div' });
export const Positioner = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getPositionerProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});

export function Actions(props: { children: (actions: Tracked<AnyRecord[]>) => Children }) @{
	const api = context.get();
	if (!api) throw new Error('Tour.Actions must be rendered inside Tour.Root');
	const actions = track(() => api.value.step?.actions ?? []);
	const render = props.children;
	{
		render(actions);
	}
}
export const Context = /*#__PURE__*/ createApiContext(context);

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
