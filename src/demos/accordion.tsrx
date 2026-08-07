import { useAccordion } from '../index';

const data = [
	{ id: 'home', label: 'Home' },
	{ id: 'about', label: 'About' },
	{ id: 'contact', label: 'Contact' },
];

export function Accordion() @{
	let api = useAccordion({
		id: 'accordion-1',
		defaultValue: ['contact'],
	});

	<>
		<div {...api.value.getRootProps()}>
			@for (const item of data) {
				<div {...api.value.getItemProps({ value: item.id })}>
					<h3>
						<button {...api.value.getItemTriggerProps({ value: item.id })}>
							{item.label}
							<span {...api.value.getItemIndicatorProps({ value: item.id })} />
						</button>
					</h3>
					<p {...api.value.getItemContentProps({ value: item.id })}>
						This is the content for{' '}
						{item.label}
					</p>
				</div>
			}
		</div>
	</>
}
