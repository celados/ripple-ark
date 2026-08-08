import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSteps } from '../components';
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

type Hook = typeof useSteps;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const stepsItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
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
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getPrevTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Separator(props: SeparatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getSeparatorProps', inheritedProps: stepsItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function NextTrigger(props: NextTriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getNextTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function List(props: ListProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getListProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Progress(props: ProgressProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getProgressProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Indicator(props: IndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getIndicatorProps', inheritedProps: stepsItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'index',
			],
			provideProps: stepsItemProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function CompletedContent(props: CompletedContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getContentProps',
			propKeys: [
				'index',
			],
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getTriggerProps', inheritedProps: stepsItemProps },
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, stepsItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type PrevTriggerProps = PartProps<'button', Api['getPrevTriggerProps']>;
export type SeparatorProps = ArkPartProps<'div'>;
export type NextTriggerProps = PartProps<'button', Api['getNextTriggerProps']>;
export type ListProps = PartProps<'div', Api['getListProps']>;
export type ProgressProps = PartProps<'div', Api['getProgressProps']>;
export type IndicatorProps = ArkPartProps<'div'>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type CompletedContentProps = PartProps<'div', Api['getContentProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type TriggerProps = ArkPartProps<'button'>;

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
