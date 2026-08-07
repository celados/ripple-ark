import { useSwitch } from '../index';

export function Switch() @{
	let api = useSwitch({
		id: 'switch',
	});

	<>
		<label {...api.value.getRootProps()}>
			<input {...api.value.getHiddenInputProps()} />
			<span {...api.value.getControlProps()}>
				<span {...api.value.getThumbProps()} />
			</span>
			<span {...api.value.getLabelProps()}>
				{api.value.checked ? 'On' : 'Off'}
			</span>
		</label>
	</>
}
