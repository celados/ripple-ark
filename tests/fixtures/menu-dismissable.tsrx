import { Menu } from '../../src/generated/menu.tsrx';

// Regression fixture for issue #6 symptom 2: an open menu installs a dismissable layer from a
// state-entry effect, so Escape / outside pointerdown must close it and `onEscapeKeyDown` /
// `onInteractOutside` must fire. Starts open so the "open" state entry effects run on mount.
export function MenuDismissable(props: {
	defaultOpen?: boolean;
	onEscapeKeyDown?: (event: any) => void;
	onInteractOutside?: (event: any) => void;
	onOpenChange?: (details: { open: boolean }) => void;
}) @{
	<Menu.Root
		defaultOpen={props.defaultOpen ?? true}
		onEscapeKeyDown={props.onEscapeKeyDown}
		onInteractOutside={props.onInteractOutside}
		onOpenChange={props.onOpenChange}
	>
		<Menu.Trigger data-testid="trigger">{'Open'}</Menu.Trigger>
		<Menu.Positioner data-testid="positioner">
			<Menu.Content data-testid="content">
				<Menu.Item value="a">{'A'}</Menu.Item>
			</Menu.Content>
		</Menu.Positioner>
	</Menu.Root>
}
