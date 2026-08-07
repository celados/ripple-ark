import { effect, Context as RippleContext, track, type Children, type Tracked } from 'ripple';
import { usePresence } from '../components';

type PresenceApi =
	Tracked<{
		present: boolean;
		unmounted: boolean;
		setNode: (node: HTMLElement | null) => void;
		presenceProps: Record<string, unknown>;
	}>;
const context = /*#__PURE__*/ new RippleContext<PresenceApi | null>(null);

export type PresenceRootProps =
	Omit<JSX.IntrinsicElements['div'], 'children'> & {
		present: boolean | Tracked<boolean>;
		lazyMount?: boolean;
		unmountOnExit?: boolean;
		skipAnimationOnMount?: boolean;
		children?: Children | Children[];
	};

export function PresenceRoot(props: PresenceRootProps) @{
	const {
		present,
		lazyMount,
		unmountOnExit,
		skipAnimationOnMount,
		children,
		ref,
		...localProps
	} = props;
	const machine = usePresence({ present });
	const wasEverPresent = track(false);
	effect(() => {
		if (machine.value.present) wasEverPresent.value = true;
	});
	const api: PresenceApi = track(
		() => ({
			present: machine.value.present,
			unmounted: !machine.value.present && !wasEverPresent.value && lazyMount ||
				Boolean(unmountOnExit) && !machine.value.present && wasEverPresent.value,
			setNode: machine.value.setNode,
			presenceProps: {
				hidden: !machine.value.present,
				'data-state': machine.value.skip && skipAnimationOnMount
					? undefined
					: (machine.value.present ? 'open' : 'closed'),
			},
		}),
	);
	context.set(api);
	<>
		@if (!api.value.unmounted) {
			<div
				{...api.value.presenceProps}
				{...localProps}
				ref={(node) => {
					api.value.setNode(node);
					if (typeof ref === 'function') ref(node);
				}}
			>{children}</div>
		}
	</>
}

export function PresenceContext(props: { children: (api: PresenceApi['value']) => Children }) @{
	const api = context.get();
	if (!api) throw new Error('Presence.Context must be rendered inside Presence.Root');
	const render = props.children;
	{
		render(api.value);
	}
}

export const Presence = { Root: PresenceRoot, Context: PresenceContext };
