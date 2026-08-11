import { FloatingPanel } from '../../src/generated/floating-panel.tsrx';
import { Select } from '../../src/generated/select.tsrx';
import { createListCollection } from '../../src/utilities/collection.ts';

const collection = createListCollection({
	items: [
		{ label: 'Apple', value: 'apple' },
		{ label: 'Banana', value: 'banana', disabled: true },
	],
});

export function SelectSemantics() @{
	<>
		<Select.Root collection={collection} defaultValue={['apple']} present lazyMount>
			<Select.HiddenSelect data-testid="hidden-select" />
			<Select.Positioner>
				<Select.Content data-testid="forced-select-content">
					<Select.ItemGroup data-testid="select-group">
						<Select.ItemGroupLabel data-testid="select-group-label">Fruit</Select.ItemGroupLabel>
					</Select.ItemGroup>
				</Select.Content>
			</Select.Positioner>
		</Select.Root>
		<FloatingPanel.Root present lazyMount>
			<FloatingPanel.Positioner>
				<FloatingPanel.Content data-testid="forced-floating-content">Panel</FloatingPanel.Content>
			</FloatingPanel.Positioner>
		</FloatingPanel.Root>
	</>
}
