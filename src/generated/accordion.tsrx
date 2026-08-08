import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAccordion } from '../components';
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

			useMachine: useAccordion as any,
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
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: accordionItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemContent(props: ItemContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemContentProps', inheritedProps: accordionItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'value',
				'disabled',
			],
			provideProps: accordionItemProps,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemTrigger(props: ItemTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTriggerProps', inheritedProps: accordionItemProps },
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, accordionItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ItemIndicatorProps = ArkPartProps<'div'>;
export type ItemContentProps = ArkPartProps<'div'>;
export type ItemProps = PartProps<'div', Api['getItemProps']>;
export type ItemTriggerProps = ArkPartProps<'button'>;

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
