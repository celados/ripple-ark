import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCollapsible } from '../components';
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

type Hook = typeof useCollapsible;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'collapsedHeight',
				'collapsedWidth',
				'defaultOpen',
				'disabled',
				'id',
				'ids',
				'lazyMount',
				'onExitComplete',
				'onOpenChange',
				'open',
				'unmountOnExit',
			],

			useMachine: useCollapsible as any,
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
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getIndicatorProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type IndicatorProps = PartProps<'div', Api['getIndicatorProps']>;

export const Collapsible = { Root, RootProvider, Trigger, Content, Indicator, Context };
