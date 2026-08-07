import { usePopover } from '../index';
import { Portal } from 'ripple';
import { LuX } from '../internal/lucide-icons.tsrx';

export function Popover() @{
	let api = usePopover({
		id: 'popover',
		portalled: true,
	});

	<>
		<button {...api.value.getTriggerProps()}>Click me</button>
		<Portal target={document.body}>
			<div {...api.value.getPositionerProps()}>
				<div {...api.value.getContentProps()}>
					<div {...api.value.getArrowProps()}>
						<div {...api.value.getArrowTipProps()} />
					</div>

					<div>
						<div {...api.value.getTitleProps()}>
							<b>Quick Settings</b>
						</div>
						<div {...api.value.getDescriptionProps()}>
							Adjust your preferences and account settings from this convenient panel.
						</div>
						<button>Update Profile</button>
					</div>
					<button {...api.value.getCloseTriggerProps()}>
						<LuX />
					</button>
				</div>
			</div>
		</Portal>
	</>
}
