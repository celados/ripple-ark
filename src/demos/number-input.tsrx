import { useNumberInput } from '../index';
import { LuChevronUp, LuChevronDown } from '../internal/lucide-icons.tsrx';

export function NumberInput() @{
	let api = useNumberInput({
		id: 'number-input',
	});

	<>
		<div {...api.value.getRootProps()}>
			<label {...api.value.getLabelProps()}>Enter number:</label>
			<div>
				<input {...api.value.getInputProps()} />
				<div>
					<button {...api.value.getIncrementTriggerProps()}>
						<LuChevronUp />
					</button>
					<button {...api.value.getDecrementTriggerProps()}>
						<LuChevronDown />
					</button>
				</div>
			</div>
		</div>
	</>
}
