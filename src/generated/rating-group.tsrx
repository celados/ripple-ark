import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useRatingGroup } from '../components';
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

type Hook = typeof useRatingGroup;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const ratingGroupItemProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'allowHalf',
				'autoFocus',
				'count',
				'defaultValue',
				'disabled',
				'form',
				'id',
				'ids',
				'name',
				'onHoverChange',
				'onValueChange',
				'readOnly',
				'required',
				'translations',
				'value',
			],

			useMachine: useRatingGroup as any,
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
export function HiddenInput(props: HiddenInputProps) @{
	<Part tag="input" options={{ context, getter: 'getHiddenInputProps' }} of={props} />
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="label" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function Control(props: ControlProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getControlProps' }} of={props}>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{
			context,
			getter: 'getItemProps',
			propKeys: [
				'index',
			],
			provideProps: ratingGroupItemProps,
		}}
		of={props}
	>{children}</Part>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, ratingGroupItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type HiddenInputProps =
	(PartProps<'input', Api['getHiddenInputProps']>) & { render?: RenderProp<'input'> };
export type LabelProps =
	(PartProps<'label', Api['getLabelProps']>) & { render?: RenderProp<'label'> };
export type ControlProps =
	(PartProps<'div', Api['getControlProps']>) & { render?: RenderProp<'div'> };
export type ItemProps = (PartProps<'span', Api['getItemProps']>) & { render?: RenderProp<'span'> };

export const RatingGroup = {
	Root,
	RootProvider,
	HiddenInput,
	Label,
	Control,
	Item,
	ItemContext,
	Context,
};
