import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useRadioGroup } from '../components';
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

type Hook = typeof useRadioGroup;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const segmentGroupItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'defaultValue',
				'disabled',
				'form',
				'id',
				'ids',
				'invalid',
				'name',
				'onValueChange',
				'orientation',
				'readOnly',
				'required',
				'value',
			],

			useMachine: useRadioGroup as any,
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
export function Item(props: ItemProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getItemProps',
			propKeys: [
				'value',
				'disabled',
				'invalid',
			],
			provideProps: segmentGroupItemProps,
		},
		props,
	);
	<label {...mergedProps.value}>{children}</label>
}
export function ItemControl(props: ItemControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemControlProps', inheritedProps: segmentGroupItemProps },
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemText(props: ItemTextProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: segmentGroupItemProps },
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Indicator(props: IndicatorProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function ItemHiddenInput(props: ItemHiddenInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemHiddenInputProps', inheritedProps: segmentGroupItemProps },
		props,
	);
	<input {...mergedProps.value} />
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, segmentGroupItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type ItemProps = PartProps<'label', Api['getItemProps']>;
export type ItemControlProps = ArkPartProps<'div'>;
export type ItemTextProps = ArkPartProps<'span'>;
export type LabelProps = PartProps<'span', Api['getLabelProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;
export type ItemHiddenInputProps = ArkPartProps<'input'>;

export const SegmentGroup = {
	Root,
	RootProvider,
	Item,
	ItemControl,
	ItemText,
	Label,
	Indicator,
	ItemHiddenInput,
	ItemContext,
	Context,
};
