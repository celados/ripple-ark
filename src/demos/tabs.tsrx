import { useTabs } from '../index.ts';

export function Tabs() @{
	let api = useTabs({
		id: 'tabs',
		defaultValue: 'overview',
	});

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getListProps()}>
				@for (const item of data) {
					<button {...api.value.getTriggerProps({ value: item.value })}>{item.label}</button>
				}
			</div>
			@for (const item of data) {
				<div {...api.value.getContentProps({ value: item.value })}>
					<p>{item.content}</p>
				</div>
			}
		</div>
	</>
}

const data = [
	{
		value: 'overview',
		label: 'Overview',
		content: 'Get an overview of the project and its main features.',
	},
	{
		value: 'features',
		label: 'Features',
		content: 'Explore the powerful features that make this framework special.',
	},
	{
		value: 'docs',
		label: 'Documentation',
		content: 'Read the comprehensive documentation and guides.',
	},
	{
		value: 'community',
		label: 'Community',
		content: 'Join our growing community of developers and contributors.',
	},
];
