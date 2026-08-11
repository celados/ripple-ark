import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAccordion } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	provideRenderStrategy,
	RENDER_STRATEGY_KEYS,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useAccordion;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const accordionItemProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'collapsible',
				'defaultValue',
				'disabled',
				'id',
				'ids',
				'multiple',
				'onFocusChange',
				'onValueChange',
				'orientation',
				'value',
			],
			omitKeys: RENDER_STRATEGY_KEYS,

			useMachine: useAccordion as any,
		},
		props,
	);
	provideRenderStrategy(props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context, omitKeys: RENDER_STRATEGY_KEYS }, props);
	provideRenderStrategy(props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemIndicatorProps', inheritedProps: accordionItemProps }}
		of={props}
	>{children}</Part>
}
export function ItemContent(props: ItemContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemContentProps', inheritedProps: accordionItemProps }}
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
				'value',
				'disabled',
			],
			provideProps: accordionItemProps,
		}}
		of={props}
	>{children}</Part>
}
export function ItemTrigger(props: ItemTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{ context, getter: 'getItemTriggerProps', inheritedProps: accordionItemProps }}
		of={props}
	>{children}</Part>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, accordionItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & {
		lazyMount?: boolean;
		unmountOnExit?: boolean;
	} & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & {
		lazyMount?: boolean;
		unmountOnExit?: boolean;
	} & { render?: RenderProp<'div'> };
export type ItemIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemContentProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'div', Api['getItemProps']>) & { render?: RenderProp<'div'> };
export type ItemTriggerProps = (ArkPartProps<'button'>) & { render?: RenderProp<'button'> };

export const Accordion = {
	Root,
	RootProvider,
	ItemIndicator,
	ItemContent,
	Item,
	ItemTrigger,
	ItemContext,
	Context,
};
