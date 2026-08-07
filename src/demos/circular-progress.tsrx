import { useProgress } from '../index.ts';

export function CircularProgress() @{
	let api = useProgress({
		id: 'circular-progress',
		defaultValue: 60,
	});

	<>
		<div>
			<div {...api.value.getRootProps()}>
				<div {...api.value.getLabelProps()}>Upload progress</div>
				<svg {...api.value.getCircleProps()}>
					<circle {...api.value.getCircleTrackProps()} />
					<circle {...api.value.getCircleRangeProps()} />
				</svg>
				<div {...api.value.getValueTextProps()}>{api.value.valueAsString}</div>
			</div>

			<div>
				<button onclick={() => api.value.setValue((api.value.value ?? 0) - 20)}>
					Decrease
				</button>

				<button onclick={() => api.value.setValue((api.value.value ?? 0) + 20)}>
					Increase
				</button>

				<button onclick={() => api.value.setValue(null)}>Indeterminate</button>
			</div>
		</div>
	</>
}
