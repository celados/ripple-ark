import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useRatingGroup } from '../components';
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

type Hook = typeof useRatingGroup;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const ratingGroupItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export function Root(props: RootProps) @{
	const children = props.children;
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
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	const children = props.children;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function HiddenInput(props: HiddenInputProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getHiddenInputProps' }, props);
	<input {...mergedProps.value} />
}
export function Label(props: LabelProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	<label {...mergedProps.value}>{children}</label>
}
export function Control(props: ControlProps) @{
	const children = props.children;
	const mergedProps = usePartProps({ context, getter: 'getControlProps' }, props);
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
			provideProps: ratingGroupItemProps,
		},
		props,
	);
	<span {...mergedProps.value}>{children}</span>
}
export const ItemContext = /*#__PURE__*/ createItemContext(context, ratingGroupItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type HiddenInputProps = PartProps<'input', Api['getHiddenInputProps']>;
export type LabelProps = PartProps<'label', Api['getLabelProps']>;
export type ControlProps = PartProps<'div', Api['getControlProps']>;
export type ItemProps = PartProps<'span', Api['getItemProps']>;

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
