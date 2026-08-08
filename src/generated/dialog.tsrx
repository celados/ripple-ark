import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useDialog } from '../components';
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

type Hook = typeof useDialog;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'aria-label',
				'closeOnEscape',
				'closeOnInteractOutside',
				'defaultOpen',
				'finalFocusEl',
				'id',
				'ids',
				'initialFocusEl',
				'modal',
				'onEscapeKeyDown',
				'onFocusOutside',
				'onInteractOutside',
				'onOpenChange',
				'onPointerDownOutside',
				'onRequestDismiss',
				'open',
				'persistentElements',
				'preventScroll',
				'restoreFocus',
				'role',
				'trapFocus',
				'triggerValue',
				'defaultTriggerValue',
				'onTriggerValueChange',
			],

			useMachine: useDialog as any,
		},
		props,
	);
	<>
		{children}
	</>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<>
		{children}
	</>
}
export function Content(props: ContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getContentProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Title(props: TitleProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTitleProps' }, props);
	<h2 {...mergedProps.value}>{children}</h2>
}
export function Trigger(props: TriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{
			context,
			getter: 'getTriggerProps',
			propKeys: [
				'value',
			],
		},
		props,
	);
	<button {...mergedProps.value}>{children}</button>
}
export function Backdrop(props: BackdropProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getBackdropProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Positioner(props: PositionerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getPositionerProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function CloseTrigger(props: CloseTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getCloseTriggerProps' }, props);
	<button {...mergedProps.value}>{children}</button>
}
export function Description(props: DescriptionProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getDescriptionProps' }, props);
	<div {...mergedProps.value}>{children}</div>
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ComponentProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ComponentProps & { value: ReturnType<Hook> };
export type ContentProps = PartProps<'div', Api['getContentProps']>;
export type TitleProps = PartProps<'h2', Api['getTitleProps']>;
export type TriggerProps = PartProps<'button', Api['getTriggerProps']>;
export type BackdropProps = PartProps<'div', Api['getBackdropProps']>;
export type PositionerProps = PartProps<'div', Api['getPositionerProps']>;
export type CloseTriggerProps = PartProps<'button', Api['getCloseTriggerProps']>;
export type DescriptionProps = PartProps<'div', Api['getDescriptionProps']>;

export const Dialog = {
	Root,
	RootProvider,
	Content,
	Title,
	Trigger,
	Backdrop,
	Positioner,
	CloseTrigger,
	Description,
	Context,
};
