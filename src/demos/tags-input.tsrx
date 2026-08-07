import { useTagsInput } from '../index.ts';
import { LuX } from '../internal/lucide-icons.tsrx';

export function TagsInput() @{
	let api = useTagsInput({
		id: 'tags-input',
		defaultValue: ['Ripple JS', 'Svelte'],
	});

	<>
		<fieldset {...api.value.getRootProps()}>
			<label {...api.value.getLabelProps()}>Enter frameworks:</label>
			<ul {...api.value.getControlProps()}>
				@for (const value of api.value.value; index index) {
					<li {...api.value.getItemProps({ index, value })}>
						<div {...api.value.getItemPreviewProps({ index, value })}>
							<span>{value}</span>
							<button {...api.value.getItemDeleteTriggerProps({ index, value })}>
								<LuX />
							</button>
						</div>
						<input {...api.value.getItemInputProps({ index, value })} />
					</li>
				}
				<input placeholder="Add tag..." {...api.value.getInputProps()} />
			</ul>
		</fieldset>
	</>
}
