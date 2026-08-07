import { useToggleGroup } from '../index.ts';
import { LuBold, LuItalic, LuUnderline } from '../internal/lucide-icons.tsrx';

export function ToggleGroup() @{
	let api = useToggleGroup({
		id: 'toggle-group',
		defaultValue: ['bold'],
		multiple: true,
	});

	<>
		<div {...api.value.getRootProps()}>
			<button {...api.value.getItemProps({ value: 'bold' })}>
				<LuBold size={16} />
			</button>
			<button {...api.value.getItemProps({ value: 'italic' })}>
				<LuItalic size={16} />
			</button>
			<button {...api.value.getItemProps({ value: 'underline' })}>
				<LuUnderline size={16} />
			</button>
		</div>
	</>
}
