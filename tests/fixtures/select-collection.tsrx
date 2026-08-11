import { Select } from '../../src/generated/select.tsrx';
import { createListCollection } from '../../src/utilities/collection.ts';

// Regression fixture for the configKeys revival: pre-fix, Select.Root's configKeys was `[]`,
// so `collection`/`defaultValue` never reached the machine (dead select) while every prop —
// including boolean ones like `lazyMount` — spread straight onto the root DOM element.
export const collection = createListCollection({
	items: [
		{ label: 'Apple', value: 'apple' },
		{ label: 'Banana', value: 'banana' },
	],
});

export function SelectCollection() @{
	<Select.Root data-testid="select-root" collection={collection} defaultValue={['apple']} lazyMount>
		<Select.Control data-testid="select-control">
			<Select.Trigger data-testid="select-trigger">
				<Select.ValueText data-testid="select-value-text" placeholder="Pick one" />
			</Select.Trigger>
		</Select.Control>
		<Select.Positioner>
			<Select.Content data-testid="select-content">
				@for (const item of collection.items) {
					<Select.Item item={item}>
						<Select.ItemText>{item.label}</Select.ItemText>
					</Select.Item>
				}
			</Select.Content>
		</Select.Positioner>
	</Select.Root>
}
