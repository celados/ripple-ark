import { useTooltip } from '../index.ts';
import { Portal } from 'ripple';

export function Tooltip() @{
	let api = useTooltip({
		id: 'tooltip',
	});

	<>
		<button {...api.value.getTriggerProps()}>Hover me</button>
		<Portal target={document.body}>
			@if (api.value.open) {
				<div {...api.value.getPositionerProps()}>
					<div {...api.value.getContentProps()}>
						<div {...api.value.getArrowProps()}>
							<div {...api.value.getArrowTipProps()} />
						</div>
						Tooltip
					</div>
				</div>
			}
		</Portal>
	</>
}
