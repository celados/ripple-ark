import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
import { anatomy } from '@zag-js/carousel';
import { useCarousel } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useCarousel;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const carouselProgressTextAttrs = /*#__PURE__*/ anatomy.build().progressText.attrs;

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
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
		},
		props,
	);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getNextTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function IndicatorGroup(props: IndicatorGroupProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getIndicatorGroupProps' }}
		of={props}
	>{children}</Part>
}
export function ProgressText(props: ProgressTextProps) @{
	let &{ children, render: _render, ...localProps } = props;
	const api = context.get()!;
	const progressText = track(() => `${api.value.page + 1} / ${api.value.pageSnapPoints.length}`);
	const mergedProps = track(() => ({ ...carouselProgressTextAttrs, ...localProps }));
	<Part tag="span" merged={mergedProps} of={props}>{children || progressText.value}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getIndicatorProps',
			propKeys: [
				'index',
				'readOnly',
			],
		}}
		of={props}
	>{children}</Part>
}
export function AutoplayIndicator(props: AutoplayIndicatorProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context }} of={props}>{children}</Part>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getPrevTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function AutoplayTrigger(props: AutoplayTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getAutoplayTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function ItemGroup(props: ItemGroupProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getItemGroupProps' }} of={props}>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getItemProps',
			propKeys: [
				'index',
				'snapAlign',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type NextTriggerProps =
	(PartProps<'button', Api['getNextTriggerProps']>) & { render?: RenderProp<'button'> };
export type IndicatorGroupProps =
	(PartProps<'div', Api['getIndicatorGroupProps']>) & { render?: RenderProp<'div'> };
export type ProgressTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type IndicatorProps =
	(PartProps<'button', Api['getIndicatorProps']>) & { render?: RenderProp<'button'> };
export type AutoplayIndicatorProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type PrevTriggerProps =
	(PartProps<'button', Api['getPrevTriggerProps']>) & { render?: RenderProp<'button'> };
export type AutoplayTriggerProps =
	(PartProps<'button', Api['getAutoplayTriggerProps']>) & { render?: RenderProp<'button'> };
export type ItemGroupProps =
	(PartProps<'div', Api['getItemGroupProps']>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };

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
