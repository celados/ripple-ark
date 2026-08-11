import { Menu } from '../../src/generated/menu.tsrx';

// Regression fixture for Menu.Item's onSelect wiring (issue #3): pre-fix, `onSelect` was never
// read off the item and no addItemListener effect existed, so clicking an item never invoked
// the consumer callback. The menu starts open so ITEM_CLICK is processed by the "open" state.
export function MenuOnSelect(props: { onSelect: () => void }) @{
	<Menu.Root defaultOpen={true}>
		<Menu.Positioner>
			<Menu.Content data-testid="menu-content">
				<Menu.Item value="opt" onSelect={props.onSelect}>
					Option
				</Menu.Item>
			</Menu.Content>
		</Menu.Positioner>
	</Menu.Root>
}
