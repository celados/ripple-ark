import { Checkbox } from '../../src/generated/checkbox.tsrx';

// Regression fixture for Checkbox.Group (checkbox.tsrx): pre-fix, Group rendered via
// usePartProps against the checkbox Root's own api context, which does not exist around a
// Group — mounting this tree threw "Ark part must be rendered inside its Root or RootProvider"
// instead of coordinating child checkboxes through group state.
export function CheckboxGroupSmoke() @{
	<Checkbox.Group defaultValue={['a']}>
		<Checkbox.Root value="a" data-testid="checkbox-a">
			<Checkbox.Control />
			<Checkbox.Label>A</Checkbox.Label>
			<Checkbox.HiddenInput />
		</Checkbox.Root>
		<Checkbox.Root value="b" data-testid="checkbox-b">
			<Checkbox.Control />
			<Checkbox.Label>B</Checkbox.Label>
			<Checkbox.HiddenInput />
		</Checkbox.Root>
	</Checkbox.Group>
}
