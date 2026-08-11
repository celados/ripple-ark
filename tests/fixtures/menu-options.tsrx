import { track } from 'ripple';
import { Menu } from '../../src/generated/menu.tsrx';

export function MenuOptions() @{
	const value = track('a');
	const checked = track(false);
	<Menu.Root defaultOpen>
		<Menu.Positioner>
			<Menu.Content>
				<Menu.RadioItemGroup
					data-testid="menu-radio-group"
					value={value.value}
					onValueChange={(details) => {
						value.value = details.value;
					}}
				>
					<Menu.ItemGroupLabel data-testid="menu-group-label">Choices</Menu.ItemGroupLabel>
					<Menu.RadioItem value="a" closeOnSelect={false} data-testid="radio-a">A</Menu.RadioItem>
					<Menu.RadioItem value="b" closeOnSelect={false} data-testid="radio-b">B</Menu.RadioItem>
				</Menu.RadioItemGroup>
				<Menu.CheckboxItem
					value="enabled"
					checked={checked.value}
					closeOnSelect={false}
					onCheckedChange={(next) => {
						checked.value = next;
					}}
					data-testid="checkbox-item"
				>Enabled</Menu.CheckboxItem>
				<Menu.ItemGroup data-testid="menu-item-group">
					<Menu.ItemGroupLabel data-testid="menu-item-group-label">Actions</Menu.ItemGroupLabel>
					<Menu.Item value="action">Action</Menu.Item>
				</Menu.ItemGroup>
			</Menu.Content>
		</Menu.Positioner>
	</Menu.Root>
}
