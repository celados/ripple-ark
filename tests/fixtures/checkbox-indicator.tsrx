import { Checkbox } from '../../src/generated/checkbox.tsrx';

export function CheckboxIndicators() @{
	<>
		<Checkbox.Root checked>
			<Checkbox.Control>
				<Checkbox.Indicator data-testid="checked-indicator" />
				<Checkbox.Indicator indeterminate data-testid="checked-indeterminate-indicator" />
			</Checkbox.Control>
		</Checkbox.Root>
		<Checkbox.Root checked="indeterminate">
			<Checkbox.Control>
				<Checkbox.Indicator indeterminate data-testid="indeterminate-indicator" />
			</Checkbox.Control>
		</Checkbox.Root>
	</>
}
