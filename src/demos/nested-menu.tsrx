import { useMenu } from '../index.ts';
import { track, Portal } from 'ripple';
import { LuChevronDown, LuChevronRight } from '../internal/lucide-icons.tsrx';

export function NestedMenu() @{
	// Level 1 - File Menu
	let fileMenu = useMenu({
		id: '1',
		'aria-label': 'File',
	});

	// Level 2 - Share Menu
	let shareMenu = useMenu({
		id: '2',
		'aria-label': 'Share',
	});

	setTimeout(() => {
		fileMenu.value.setChild(shareMenu.service);
		shareMenu.value.setParent(fileMenu.service);
	});

	// Share menu trigger
	const shareMenuTriggerProps = track(() => fileMenu.value.getTriggerItemProps(shareMenu.value));

	<>
		<button {...fileMenu.value.getTriggerProps()}>
			Click me
			<span {...fileMenu.value.getIndicatorProps()}>
				<LuChevronDown />
			</span>
		</button>

		<Portal target={document.body}>
			<div {...fileMenu.value.getPositionerProps()}>
				<ul {...fileMenu.value.getContentProps()}>
					@for (const item of data) {
						<li {...fileMenu.value.getItemProps({ value: item.value })}>{item.label}</li>
					}
					<li {...shareMenuTriggerProps.value}>
						Share
						<span {...shareMenu.value.getIndicatorProps()}>
							<LuChevronRight />
						</span>
					</li>
				</ul>
			</div>
		</Portal>

		<Portal target={document.body}>
			<div {...shareMenu.value.getPositionerProps()}>
				<ul {...shareMenu.value.getContentProps()}>
					@for (const item of shareMenuData) {
						<li {...shareMenu.value.getItemProps({ value: item.value })}>{item.label}</li>
					}
				</ul>
			</div>
		</Portal>
	</>
}

const data = [
	{ value: 'new', label: 'New File' },
	{ value: 'open', label: 'Open File' },
	{ value: 'save', label: 'Save' },
	{ value: 'export', label: 'Export' },
];

const shareMenuData = [
	{ value: 'email', label: 'Email' },
	{ value: 'copy-link', label: 'Copy Link' },
	{ value: 'social', label: 'Social Media' },
	{ value: 'print', label: 'Print' },
];
