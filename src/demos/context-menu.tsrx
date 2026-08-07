import { useMenu } from '../index';

export function ContextMenu() @{
	let api = useMenu({
		id: 'context-menu',
	});

	<>
		<div {...api.value.getContextTriggerProps()}>
			<div>Open context menu</div>
		</div>
		<div {...api.value.getPositionerProps()}>
			<ul {...api.value.getContentProps()}>
				@for (const item of data) {
					<li {...api.value.getItemProps({ value: item.value })}>{item.label}</li>
				}
			</ul>
		</div>
	</>
}

const data = [
	{ value: 'copy', label: 'Copy' },
	{ value: 'cut', label: 'Cut' },
	{ value: 'paste', label: 'Paste' },
	{ value: 'rename', label: 'Rename' },
	{ value: 'delete', label: 'Delete' },
];
