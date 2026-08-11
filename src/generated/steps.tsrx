import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSteps } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	createRenderContent,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useSteps;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const stepsItemProps = /*#__PURE__*/ new RippleContext<Tracked<Record<string, any>> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPrevTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function Separator(props: SeparatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getSeparatorProps', inheritedProps: stepsItemProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getNextTriggerProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export function List(props: ListProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getListProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Progress(props: ProgressProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getProgressProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getIndicatorProps', inheritedProps: stepsItemProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function CompletedContent(props: CompletedContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
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
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getTriggerProps', inheritedProps: stepsItemProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<button {...mergedProps.value}>{children}</button>
	}
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, stepsItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type PrevTriggerProps =
	(PartProps<'button', Api['getPrevTriggerProps']>) & { render?: RenderProp<'button'> };
export type SeparatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type NextTriggerProps =
	(PartProps<'button', Api['getNextTriggerProps']>) & { render?: RenderProp<'button'> };
export type ListProps = (PartProps<'div', Api['getListProps']>) & { render?: RenderProp<'div'> };
export type ProgressProps =
	(PartProps<'div', Api['getProgressProps']>) & { render?: RenderProp<'div'> };
export type IndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type CompletedContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type TriggerProps = (ArkPartProps<'button'>) & { render?: RenderProp<'button'> };

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
