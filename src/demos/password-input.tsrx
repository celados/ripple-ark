import { usePasswordInput } from '../index.ts';
import { LuEye, LuEyeOff } from '../internal/lucide-icons.tsrx';

export function PasswordInput() @{
	let api = usePasswordInput({
		id: 'password-input',
	});

	<>
		<div {...api.value.getRootProps()}>
			<label {...api.value.getLabelProps()}>Password</label>
			<div {...api.value.getControlProps()}>
				<input {...api.value.getInputProps()} />
				<button {...api.value.getVisibilityTriggerProps()}>
					<span {...api.value.getIndicatorProps()}>
						@if (api.value.visible) {
							<LuEye />
						} @else {
							<LuEyeOff />
						}
					</span>
				</button>
			</div>
		</div>
	</>
}
