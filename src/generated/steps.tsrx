import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSteps } from '../components.ts';
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

const context = new RippleContext<Tracked<Api> | null>(null);

const stepsItemProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
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
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const PrevTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getPrevTriggerProps',
});
export const Separator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getSeparatorProps',
	inheritedProps: stepsItemProps,
});
export const NextTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getNextTriggerProps',
});
export const List = createPart({ context, defaultTag: 'div', getter: 'getListProps' });
export const Progress = createPart({ context, defaultTag: 'div', getter: 'getProgressProps' });
export const Indicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorProps',
	inheritedProps: stepsItemProps,
});
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'index',
	],
	provideProps: stepsItemProps,
});
export const CompletedContent = createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
});
export const Content = createPart({
	context,
	defaultTag: 'div',
	getter: 'getContentProps',
	propKeys: [
		'index',
	],
});
export const Trigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getTriggerProps',
	inheritedProps: stepsItemProps,
});
export const ItemContext = createItemContext(context, stepsItemProps);

export const Context = createApiContext(context);

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
