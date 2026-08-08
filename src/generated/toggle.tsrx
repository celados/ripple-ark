import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useToggle } from '../components';
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

type Hook = typeof useToggle;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'pressed',
				'defaultPressed',
				'disabled',
				'onPressedChange',
			],

			useMachine: useToggle as any,
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'button'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'button'> & { value: ReturnType<Hook> };
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;

export const Toggle = { Root, RootProvider, Indicator, Context };
