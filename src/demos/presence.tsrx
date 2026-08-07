import { usePresence } from '../index';
import { track } from 'ripple';

export function Presence() @{
	let present = track(false);

	let api = usePresence({
		present,
	});

	const divRef = (node: HTMLDivElement) => {
		api.value.setNode(node);
	};

	<>
		<div data-scope="presence" data-part="root">
			<button onclick={() => (present.value = !present.value)}>Toggle</button>
			@if (api.value.present) {
				<div
					ref={divRef}
					data-scope="presence"
					data-part="content"
					data-state={present.value ? 'open' : 'closed'}
				>
					Content
				</div>
			}
		</div>
	</>
}
