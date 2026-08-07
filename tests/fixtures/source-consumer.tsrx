import { Accordion } from '@celados/ripple-ark/accordion';
import { Checkbox } from '@celados/ripple-ark/checkbox';

export function SourceConsumer() @{
	<>
		<Accordion.Root id="source-accordion" defaultValue={['first']}>
			<Accordion.Item value="first">
				<Accordion.ItemTrigger>First</Accordion.ItemTrigger>
				<Accordion.ItemContent>First content</Accordion.ItemContent>
			</Accordion.Item>
		</Accordion.Root>
		<Checkbox.Root id="source-checkbox">
			<Checkbox.Control />
			<Checkbox.Label>Accept</Checkbox.Label>
			<Checkbox.HiddenInput />
		</Checkbox.Root>
	</>
}
