import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSteps } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useSteps;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const stepsItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'count',
		'defaultStep',
		'id',
		'ids',
		'isStepSkippable',
		'isStepValid',
		'linear',
		'onStepChange',
		'onStepComplete',
		'onStepInvalid',
		'orientation',
		'step',
	],

	useMachine: useSteps as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const PrevTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getPrevTriggerProps',
});
export const Separator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getSeparatorProps',
	inheritedProps: stepsItemProps,
});
export const NextTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getNextTriggerProps',
});
export const List = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getListProps',
});
export const Progress = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getProgressProps',
});
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
	inheritedProps: stepsItemProps,
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'index',
	],
	provideProps: stepsItemProps,
});
export const CompletedContent = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const Content = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
	propKeys: [
		'index',
	],
});
export const Trigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	inheritedProps: stepsItemProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, stepsItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type PrevTriggerProps = ArkPartProps;
export type SeparatorProps = ArkPartProps;
export type NextTriggerProps = ArkPartProps;
export type ListProps = ArkPartProps;
export type ProgressProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type CompletedContentProps = ArkPartProps;
export type ContentProps = ArkPartProps;
export type TriggerProps = ArkPartProps;

export const Steps = {
	Root,
	RootProvider,
	PrevTrigger,
	Separator,
	NextTrigger,
	List,
	Progress,
	Indicator,
	Item,
	CompletedContent,
	Content,
	Trigger,
	ItemContext,
	Context,
};
