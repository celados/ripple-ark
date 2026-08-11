import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTooltip } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
	useRootPresence,
	PRESENCE_KEYS,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
	type PresenceState,
} from '../binding-runtime.tsrx';

type Hook = typeof useTooltip;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	// Rootless upstream: the call runs for its machine/context side effects only.
	useRootProps(
		{
			context,
			configKeys: [
				'aria-label',
				'closeDelay',
				'closeOnClick',
				'closeOnEscape',
				'closeOnPointerDown',
				'closeOnScroll',
				'defaultOpen',
				'disabled',
				'id',
				'ids',
				'interactive',
				'onOpenChange',
				'open',
				'openDelay',
				'positioning',
				'triggerValue',
				'defaultTriggerValue',
				'onTriggerValueChange',
			],
			omitKeys: PRESENCE_KEYS,

			useMachine: useTooltip as any,
		},
		props,
	);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	<>
		{children}
	</>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getPositionerProps' }}
		presence={presenceContext}
		gate
		of={props}
	>{children}</Part>
}
export function Arrow(props: ArrowProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowProps' }} of={props}>{children}</Part>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getContentProps', presence: presenceContext, omitKeys: ['ref'] }}
		presence={presenceContext}
		gate
		composeRef
		of={props}
	>{children}</Part>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	<Part
		tag="button"
		options={{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
		}}
		of={props}
	>{children}</Part>
}
export function ArrowTip(props: ArrowTipProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getArrowTipProps' }} of={props}>{children}</Part>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ComponentProps & NonNullable<Parameters<Hook>[0]> & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type RootProviderProps =
	ComponentProps & { value: ReturnType<Hook> } & {
		present?: boolean;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		onExitComplete?: () => void;
		immediate?: boolean;
		skipAnimationOnMount?: boolean;
	};
export type PositionerProps =
	(PartProps<'div', Api['getPositionerProps']>) & { render?: RenderProp<'div'> };
export type ArrowProps = (PartProps<'div', Api['getArrowProps']>) & { render?: RenderProp<'div'> };
export type ContentProps =
	(PartProps<'div', Api['getContentProps']>) & { render?: RenderProp<'div'> };
export type TriggerProps =
	(PartProps<'button', Api['getTriggerProps']>) & { render?: RenderProp<'button'> };
export type ArrowTipProps =
	(PartProps<'div', Api['getArrowTipProps']>) & { render?: RenderProp<'div'> };

export const Tooltip = {
	Root,
	RootProvider,
	Positioner,
	Arrow,
	Content,
	Trigger,
	ArrowTip,
	Context,
};
