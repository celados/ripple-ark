import { Context as RippleContext, type Tracked } from 'ripple';
import { useCascadeSelect } from '../components';
import {
	createApiContext,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type PartOptions,
	type PartProps,
} from '../binding-runtime.tsrx';

export type Api = ReturnType<typeof useCascadeSelect>['value'];
const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const itemProps = /*#__PURE__*/ new RippleContext<Tracked<Record<string, any>> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'id',
				'collection',
				'defaultValue',
				'value',
				'onValueChange',
				'disabled',
				'invalid',
				'readOnly',
				'required',
				'open',
				'defaultOpen',
				'onOpenChange',
				'positioning',
			],
			useMachine: useCascadeSelect as any,
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

function createStaticPart<T extends keyof JSX.IntrinsicElements>(
	props: ArkPartProps<T>,
	options: PartOptions<Api>,
) {
	return usePartProps(options, props);
}

export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, { context, getter: 'getLabelProps' });
	<label {...mergedProps.value}>{children}</label>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, { context, getter: 'getControlProps' });
	<div {...mergedProps.value}>{children}</div>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, { context, getter: 'getTriggerProps' });
	<button {...mergedProps.value}>{children}</button>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, { context, getter: 'getIndicatorProps' });
	<span {...mergedProps.value}>{children}</span>
}
export function ClearTrigger(props: ClearTriggerProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, { context, getter: 'getClearTriggerProps' });
	<button {...mergedProps.value}>{children}</button>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, { context, getter: 'getPositionerProps' });
	<div {...mergedProps.value}>{children}</div>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, { context, getter: 'getContentProps' });
	<div {...mergedProps.value}>{children}</div>
}
export function List(props: ListProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, {
		context,
		getter: 'getListProps',
		propKeys: ['indexPath', 'value', 'item'],
	});
	<ul {...mergedProps.value}>{children}</ul>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, {
		context,
		getter: 'getItemProps',
		propKeys: ['indexPath', 'value', 'item'],
		provideProps: itemProps,
	});
	<li {...mergedProps.value}>{children}</li>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, {
		context,
		getter: 'getItemTextProps',
		inheritedProps: itemProps,
	});
	<span {...mergedProps.value}>{children}</span>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = createStaticPart(props, {
		context,
		getter: 'getItemIndicatorProps',
		inheritedProps: itemProps,
	});
	<span {...mergedProps.value}>{children}</span>
}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<typeof useCascadeSelect>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: Tracked<Api> };
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type IndicatorProps = PartProps<'span', Api['getIndicatorProps']>;
export type ClearTriggerProps = PartProps<'button', Api['getClearTriggerProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type ListProps = PartProps<'ul', Api['getListProps']>;
export type ItemProps = PartProps<'li', Api['getItemProps']>;
export type ItemTextProps = ArkPartProps<'span'>;
export type ItemIndicatorProps = ArkPartProps<'span'>;
export const CascadeSelect = {
	Root,
	RootProvider,
	Label,
	Control,
	Trigger,
	Indicator,
	ClearTrigger,
	Positioner,
	Content,
	List,
	Item,
	ItemText,
	ItemIndicator,
	Context,
};
