import { parseTimerDuration, useTimer } from '../index.ts';

export function Timer() @{
	let api = useTimer({
		id: 'timer',
		countdown: true,
		autoStart: true,
		startMs: parseTimerDuration({ days: 2, seconds: 10 }),
		interval: 1000,
	});

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getAreaProps()}>
				<div {...api.value.getItemProps({ type: 'days' })}>{api.value.formattedTime.days}</div>
				<div {...api.value.getSeparatorProps()}>:</div>
				<div {...api.value.getItemProps({ type: 'hours' })}>{api.value.formattedTime.hours}</div>
				<div {...api.value.getSeparatorProps()}>:</div>
				<div
					{...api.value.getItemProps({ type: 'minutes' })}
				>{api.value.formattedTime.minutes}</div>
				<div {...api.value.getSeparatorProps()}>:</div>
				<div
					{...api.value.getItemProps({ type: 'seconds' })}
				>{api.value.formattedTime.seconds}</div>
			</div>

			<div {...api.value.getControlProps()}>
				<button {...api.value.getActionTriggerProps({ action: 'pause' })}>
					Pause
				</button>
				<button {...api.value.getActionTriggerProps({ action: 'resume' })}>
					Resume
				</button>
			</div>
		</div>
	</>
}
