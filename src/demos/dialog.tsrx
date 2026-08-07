import { useDialog } from '../index';
import { Portal } from 'ripple';
import { LuX } from '../internal/lucide-icons.tsrx';

export function Dialog() @{
	let api = useDialog({
		id: 'dialog',
	});

	<>
		<button {...api.value.getTriggerProps()}>Open Dialog</button>
		<Portal target={document.body}>
			<div {...api.value.getBackdropProps()} />
			<div {...api.value.getPositionerProps()}>
				<div {...api.value.getContentProps()}>
					<h2 {...api.value.getTitleProps()}>Edit profile</h2>
					<p {...api.value.getDescriptionProps()}>
						Make changes to your profile here. Click save when you are done.
					</p>

					<div>
						<input placeholder="Enter name..." />
						<button>Save</button>
					</div>
					<button {...api.value.getCloseTriggerProps()}>
						<LuX />
					</button>
				</div>
			</div>
		</Portal>
	</>
}
