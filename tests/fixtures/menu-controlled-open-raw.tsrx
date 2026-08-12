import { track } from 'ripple';
import { Menu } from '../../src/generated/menu.tsrx';
import type { ControlledHandle } from './menu-controlled-open.tsrx';

// Same contract as menu-controlled-open.tsrx, but `open` crosses the boundary as a raw value
// rather than a Tracked box. Issue #6 reported both forms behaving identically, so both are
// pinned: the value form depends on the prop getter staying live through ark's two getter layers.
export function MenuControlledOpenRaw(props: { onReady: (handle: ControlledHandle) => void }) @{
	let &[menuOpen, menuOpenTracked] = track(false);
	const changes: boolean[] = [];

	props.onReady({
		setOpen(value: boolean) {
			menuOpenTracked.value = value;
		},
		getOpen() {
			return menuOpenTracked.value;
		},
		changes,
	});

	<Menu.Root
		open={menuOpen}
		onOpenChange={(details) => {
			changes.push(details.open);
			menuOpen = details.open;
		}}
	>
		<Menu.Trigger data-testid="trigger">{'Open'}</Menu.Trigger>
		<Menu.Positioner data-testid="positioner">
			<Menu.Content data-testid="content">
				<Menu.Item value="a">{'A'}</Menu.Item>
			</Menu.Content>
		</Menu.Positioner>
	</Menu.Root>
}
