import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useRadioGroup } from '../components';
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

type Hook = typeof useRadioGroup;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const segmentGroupItemProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="label"
		options={{
			context,
			getter: 'getItemProps',
			propKeys: [
				'value',
				'disabled',
				'invalid',
			],
			provideProps: segmentGroupItemProps,
		}}
		of={props}
	>{children}</Part>
}
export function ItemControl(props: ItemControlProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemControlProps', inheritedProps: segmentGroupItemProps }}
		of={props}
	>{children}</Part>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getItemTextProps', inheritedProps: segmentGroupItemProps }}
		of={props}
	>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getIndicatorProps' }} of={props}>{children}</Part>
}
export function ItemHiddenInput(props: ItemHiddenInputProps) @{
	<Part
		tag="input"
		options={{ context, getter: 'getItemHiddenInputProps', inheritedProps: segmentGroupItemProps }}
		of={props}
	/>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, segmentGroupItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type ItemProps =
	(PartProps<'label', Api['getItemProps']>) & { render?: RenderProp<'label'> };
export type ItemControlProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type LabelProps =
	(PartProps<'span', Api['getLabelProps']>) & { render?: RenderProp<'span'> };
export type IndicatorProps =
	(PartProps<'div', Api['getIndicatorProps']>) & { render?: RenderProp<'div'> };
export type ItemHiddenInputProps = (ArkPartProps<'input'>) & { render?: RenderProp<'input'> };

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
