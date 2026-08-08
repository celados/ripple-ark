import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCarousel } from '../components';
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

type Hook = typeof useCarousel;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getNextTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function IndicatorGroup(props: IndicatorGroupProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorGroupProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ProgressText(props: ProgressTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getIndicatorProps',
			propKeys: [
				'index',
				'readOnly',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function AutoplayIndicator(props: AutoplayIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPrevTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function AutoplayTrigger(props: AutoplayTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getAutoplayTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function ItemGroup(props: ItemGroupProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getItemGroupProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'index',
				'snapAlign',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type NextTriggerProps = PartProps<'button', Api['getNextTriggerProps']>;
export type IndicatorGroupProps = PartProps<'div', Api['getIndicatorGroupProps']>;
export type ProgressTextProps = ArkPartProps<'span'>;
export type IndicatorProps = PartProps<'button', Api['getIndicatorProps']>;
export type AutoplayIndicatorProps = ArkPartProps<'span'>;
export type PrevTriggerProps = PartProps<'button', Api['getPrevTriggerProps']>;
export type AutoplayTriggerProps = PartProps<'button', Api['getAutoplayTriggerProps']>;
export type ItemGroupProps = PartProps<'div', Api['getItemGroupProps']>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;

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
