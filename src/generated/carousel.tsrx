import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCarousel } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useCarousel;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'allowMouseDrag',
		'autoplay',
		'autoSize',
		'defaultPage',
		'id',
		'ids',
		'inViewThreshold',
		'loop',
		'onAutoplayStatusChange',
		'onDragStatusChange',
		'onPageChange',
		'orientation',
		'padding',
		'page',
		'slideCount',
		'slidesPerMove',
		'slidesPerPage',
		'snapType',
		'spacing',
		'translations',
	],

	useMachine: useCarousel as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const NextTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getNextTriggerProps',
});
export const IndicatorGroup = createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorGroupProps',
});
export const ProgressText = createPart({ context, defaultTag: 'span' });
export const Indicator = createPart({
	context,
	defaultTag: 'button',
	getter: 'getIndicatorProps',
	propKeys: [
		'index',
		'readOnly',
	],
});
export const AutoplayIndicator = createPart({ context, defaultTag: 'span' });
export const PrevTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getPrevTriggerProps',
});
export const AutoplayTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getAutoplayTriggerProps',
});
export const ItemGroup = createPart({ context, defaultTag: 'div', getter: 'getItemGroupProps' });
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'index',
		'snapAlign',
	],
});
export const Control = createPart({ context, defaultTag: 'div', getter: 'getControlProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type NextTriggerProps = ArkPartProps;
export type IndicatorGroupProps = ArkPartProps;
export type ProgressTextProps = ArkPartProps;
export type IndicatorProps = ArkPartProps;
export type AutoplayIndicatorProps = ArkPartProps;
export type PrevTriggerProps = ArkPartProps;
export type AutoplayTriggerProps = ArkPartProps;
export type ItemGroupProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type ControlProps = ArkPartProps;

export const Carousel = {
	Root,
	RootProvider,
	NextTrigger,
	IndicatorGroup,
	ProgressText,
	Indicator,
	AutoplayIndicator,
	PrevTrigger,
	AutoplayTrigger,
	ItemGroup,
	Item,
	Control,
	Context,
};
