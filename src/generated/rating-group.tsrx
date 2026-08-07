import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useRatingGroup } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useRatingGroup;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const ratingGroupItemProps = /*#__PURE__*/ new RippleContext<Record<string, any> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
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
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const HiddenInput = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'input',
	getter: 'getHiddenInputProps',
});
export const Label = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'label',
	getter: 'getLabelProps',
});
export const Control = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'div',
	getter: 'getControlProps',
});
export const Item = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemProps',
	propKeys: [
		'index',
	],
	provideProps: ratingGroupItemProps,
});
export const ItemContext = /*#__PURE__*/ createItemContext(context, ratingGroupItemProps);

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type HiddenInputProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type ControlProps = ArkPartProps;
export type ItemProps = ArkPartProps;

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
