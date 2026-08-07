import { useSplitter } from '../index';

export function Splitter() @{
	let api = useSplitter({
		id: 'splitter',
		panels: [{ id: 'a' }, { id: 'b' }],
		defaultSize: [50, 50],
	});

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getPanelProps({ id: 'a' })}>
				<p>A</p>
			</div>
			<div {...api.value.getResizeTriggerProps({ id: 'a:b' })} />
			<div {...api.value.getPanelProps({ id: 'b' })}>
				<p>B</p>
			</div>
		</div>
	</>
}
