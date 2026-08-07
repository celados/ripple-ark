import { effect, track, type Children } from 'ripple';

export type ClientOnlyProps = {
	children: Children | Children[];
	fallback?: Children | Children[];
};

export function ClientOnly(props: ClientOnlyProps) @{
	const mounted = track(false);
	effect(() => {
		mounted.value = true;
	});

	<>
		@if (mounted.value) {
			{
				props.children;
			}
		} @else {
			{
				props.fallback;
			}
		}
	</>
}
