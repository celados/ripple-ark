import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useSteps } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function PrevTrigger(props: PrevTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getPrevTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function Separator(props: SeparatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getSeparatorProps', inheritedProps: stepsItemProps }}
		of={props}
	>{children}</Part>
}
export function NextTrigger(props: NextTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getNextTriggerProps' }}
		of={props}
	>{children}</Part>
}
export function List(props: ListProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getListProps' }} of={props}>{children}</Part>
}
export function Progress(props: ProgressProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getProgressProps' }} of={props}>{children}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getIndicatorProps', inheritedProps: stepsItemProps }}
		of={props}
	>{children}</Part>
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
			],
			provideProps: stepsItemProps,
		}}
		of={props}
	>{children}</Part>
}
export function CompletedContent(props: CompletedContentProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getContentProps' }} of={props}>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{
			context,
			getter: 'getContentProps',
			propKeys: [
				'index',
			],
		}}
		of={props}
	>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getTriggerProps', inheritedProps: stepsItemProps }}
		of={props}
	>{children}</Part>
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
