import { track } from 'ripple';
import { Menu } from '../../src/generated/menu.tsrx';

export type ControlledHandle = {
	setOpen(value: boolean): void;
	getOpen(): boolean;
	changes: boolean[];
};

// Regression fixture for issue #6 symptom 1: a controlled `open` prop must drive the machine
// in both directions. The uncontrolled/user-event path works, so the assertion that matters is
// the outside write (`setOpen`) reaching the machine's `watch` on `prop("open")`.
export function MenuControlledOpen(props: { onReady: (handle: ControlledHandle) => void }) @{
	const open = track(false);
	const changes: boolean[] = [];

	props.onReady({
		setOpen(value: boolean) {
			open.value = value;
		},
		getOpen() {
			return open.value;
		},
		changes,
	});

	<Menu.Root
		open={open}
		onOpenChange={(details) => {
			changes.push(details.open);
			open.value = details.open;
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
