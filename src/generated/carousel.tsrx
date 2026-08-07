import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCarousel } from '../components';
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

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
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
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const NextTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getNextTriggerProps',
});
export const IndicatorGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getIndicatorGroupProps',
});
export const ProgressText = /*#__PURE__*/ createPart({ context, defaultTag: 'span' });
export const Indicator = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getIndicatorProps',
	propKeys: [
		'index',
		'readOnly',
	],
});
export const AutoplayIndicator = /*#__PURE__*/ createPart({ context, defaultTag: 'span' });
export const PrevTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getPrevTriggerProps',
});
export const AutoplayTrigger = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'button',
	getter: 'getAutoplayTriggerProps',
});
export const ItemGroup = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemGroupProps',
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	propKeys: [
		'index',
		'snapAlign',
	],
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

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
