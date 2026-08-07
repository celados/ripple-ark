import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useToggle } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useToggle;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'button',
	configKeys: [
		'pressed',
		'defaultPressed',
		'disabled',
		'onPressedChange',
	],

	useMachine: useToggle as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'button' });
export const Indicator = createPart({ context, defaultTag: 'div', getter: 'getIndicatorProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type IndicatorProps = ArkPartProps;

export const Toggle = { Root, RootProvider, Indicator, Context };
