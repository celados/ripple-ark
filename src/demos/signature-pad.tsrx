import { useSignaturePad } from '../index';
import { LuRotateCcw } from '../internal/lucide-icons.tsrx';

export function SignaturePad() @{
	let api = useSignaturePad({
		id: 'signature-pad',
	});

	<>
		<div {...api.value.getRootProps()}>
			<label {...api.value.getLabelProps()}>Sign here</label>

			<div {...api.value.getControlProps()}>
				<svg {...api.value.getSegmentProps()}>
					@for (const path of api.value.paths; index i) {
						<path {...api.value.getSegmentPathProps({ path })} />
					}
					@if (api.value.currentPath) {
						<path {...api.value.getSegmentPathProps({ path: api.value.currentPath })} />
					}
				</svg>

				<button {...api.value.getClearTriggerProps()}>
					<LuRotateCcw />
				</button>

				<div {...api.value.getGuideProps()} />
			</div>
		</div>
	</>
}
