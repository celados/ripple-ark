import { useClipboard } from '../index';
import { LuCheck, LuClipboardCopy } from '../internal/lucide-icons.tsrx';

export function Clipboard() @{
	let api = useClipboard({
		id: 'clipboard',
		value: 'https://www.tsrxjs.com/',
	});

	<>
		<div {...api.value.getRootProps()}>
			<label {...api.value.getLabelProps()}>Copy this link</label>
			<div {...api.value.getControlProps()}>
				<input {...api.value.getInputProps()} />
				<button {...api.value.getTriggerProps()}>
					@if (api.value.copied) {
						<LuCheck />
					} @else {
						<LuClipboardCopy />
					}
				</button>
			</div>
		</div>
	</>
}
