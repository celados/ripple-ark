import { track } from 'ripple';
import { Menu } from '../../src/generated/menu.tsrx';
import { Popover } from '../../src/generated/popover.tsrx';

// Models the reporting app's shape (celados/ripple-ark#6): a Popover held permanently open with
// its own dismissal disabled, standing in @zag-js/dismissable's global layer stack, while a Menu
// is opened and dismissed beside it. Only the top-most layer answers Escape / outside pointerdown,
// so a standing layer is the app-level difference the adapter's own fixtures never had.
export function MenuWithStandingLayer(props: {
	initialLayer?: boolean;
	onReady?: (handle: { showLayer(value: boolean): void }) => void;
	onEscapeKeyDown?: (event: any) => void;
	onInteractOutside?: (event: any) => void;
}) @{
	const layerVisible = track(props.initialLayer ?? true);

	props.onReady?.({
		showLayer(value: boolean) {
			layerVisible.value = value;
		},
	});

	<>
		@if (layerVisible.value) {
			<Popover.Root
				open={true}
				modal={false}
				autoFocus={false}
				closeOnEscape={false}
				closeOnInteractOutside={false}
			>
				<Popover.Positioner>
					<Popover.Content data-testid="standing-layer">{'standing'}</Popover.Content>
				</Popover.Positioner>
			</Popover.Root>
		}
		<Menu.Root
			onEscapeKeyDown={props.onEscapeKeyDown}
			onInteractOutside={props.onInteractOutside}
		>
			<Menu.Trigger data-testid="trigger">{'Open'}</Menu.Trigger>
			<Menu.Positioner>
				<Menu.Content data-testid="content">
					<Menu.Item value="a">{'A'}</Menu.Item>
				</Menu.Content>
			</Menu.Positioner>
		</Menu.Root>
	</>
}
