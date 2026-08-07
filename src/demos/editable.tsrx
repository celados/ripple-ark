import { useEditable } from '../index.ts';

export function Editable() @{
	let api = useEditable({
		id: 'editable',
		placeholder: 'Enter your text...',
		submitMode: 'enter',
	});

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getAreaProps()}>
				<input {...api.value.getInputProps()} />
				<span {...api.value.getPreviewProps()}>{api.value.valueText}</span>
			</div>

			<div {...api.value.getControlProps()}>
				@if (api.value.editing) {
					<>
						<button {...api.value.getSubmitTriggerProps()}>Save</button>
						<button {...api.value.getCancelTriggerProps()}>Cancel</button>
					</>
				} @else {
					<button {...api.value.getEditTriggerProps()}>Edit</button>
				}
			</div>
		</div>
	</>
}
