import { useMenu } from '../index';
import { Portal } from 'ripple';
import { LuChevronDown } from '../internal/lucide-icons.tsrx';

export function Menu() @{
	let api = useMenu({
		id: 'menu',
	});

	<>
		<button {...api.value.getTriggerProps()}>
			Actions
			<span {...api.value.getIndicatorProps()}>
				<LuChevronDown />
			</span>
		</button>
		<Portal target={document.body}>
			<div {...api.value.getPositionerProps()}>
				<ul {...api.value.getContentProps()}>
					@for (const item of data) {
						<li {...api.value.getItemProps({ value: item.value })}>{item.label}</li>
					}
				</ul>
			</div>
		</Portal>
	</>
}

const data = [
	{ value: 'edit', label: 'Edit' },
	{ value: 'duplicate', label: 'Duplicate' },
	{ value: 'archive', label: 'Archive' },
	{ value: 'delete', label: 'Delete' },
];
