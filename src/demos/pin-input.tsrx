import { usePinInput } from '../index.ts';

export function PinInput() @{
	let api = usePinInput({
		id: 'pin-input',
		placeholder: '○',
		count: 4,
	});

	<>
		<div {...api.value.getRootProps()}>
			<label {...api.value.getLabelProps()}>Enter code:</label>
			<div {...api.value.getControlProps()}>
				@for (const index of api.value.items) {
					<input {...api.value.getInputProps({ index })} />
				}
			</div>
			<input {...api.value.getHiddenInputProps()} />
			<button onClick={() => api.value.clearValue()}>Clear</button>
		</div>
	</>
}
