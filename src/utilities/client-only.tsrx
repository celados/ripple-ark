import { effect, track, type Children } from 'ripple';

export type ClientOnlyProps = {
	render: () => Children | Children[];
	fallback?: Children | Children[];
};

export function ClientOnly(props: ClientOnlyProps) @{
	let &{ render, fallback } = props;
	const mounted = track(false);
	effect(() => {
		mounted.value = true;
	});

	// The host preserves a hydration anchor when the server fallback is empty.
	<span style="display: contents">
		@if (mounted.value) {
			<{render} />
		} @else {
			{
				fallback;
			}
		}
	</span>
}
