import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useToggleGroup } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useToggleGroup;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'defaultValue',
		'deselectable',
		'disabled',
		'id',
		'ids',
		'loopFocus',
		'multiple',
		'onValueChange',
		'orientation',
		'rovingFocus',
		'value',
	],

	useMachine: useToggleGroup as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const Item = createPart({
	context,
	defaultTag: 'button',
	getter: 'getItemProps',
	propKeys: [
		'value',
		'disabled',
	],
});

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type ItemProps = ArkPartProps;

export const ToggleGroup = { Root, RootProvider, Item, Context };
