import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useCollapsible } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part tag="button" options={{ context, getter: 'getTriggerProps' }} of={props}>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getContentProps' }} of={props}>{children}</Part>
}
export function Indicator(props: IndicatorProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getIndicatorProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type IndicatorProps =
	(PartProps<'div', Api['getIndicatorProps']>) & { render?: RenderProp<'div'> };

export const Collapsible = { Root, RootProvider, Trigger, Content, Indicator, Context };
