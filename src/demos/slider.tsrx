import { useSlider } from '../index';

export function Slider() @{
	let api = useSlider({
		id: 'slider',
		min: -50,
		max: 50,
		defaultValue: [20],
	});

	<>
		<div {...api.value.getRootProps()}>
			<div>
				<label {...api.value.getLabelProps()}>Quantity</label>
				<output {...api.value.getValueTextProps()}>
					<b>{api.value.value.at(0)}</b>
				</output>
			</div>

			<div {...api.value.getControlProps()}>
				<div {...api.value.getTrackProps()}>
					<div {...api.value.getRangeProps()} />
				</div>
				<div {...api.value.getThumbProps({ index: 0 })}>
					<input {...api.value.getHiddenInputProps({ index: 0 })} />
				</div>
			</div>
		</div>
	</>
}
