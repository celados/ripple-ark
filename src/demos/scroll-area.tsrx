import { useScrollArea } from '../index';

export function ScrollArea() @{
	let api = useScrollArea({
		id: 'scroll-area',
	});

	<>
		<div {...api.value.getRootProps()}>
			<div {...api.value.getViewportProps()}>
				<div {...api.value.getContentProps()}>
					@for (const index of Array.from({ length: 50 }, (_, i) => i)) {
						<div>
							Item
							{index + 1}
						</div>
					}
				</div>
			</div>
			<div {...api.value.getScrollbarProps()}>
				<div {...api.value.getThumbProps()} />
			</div>
		</div>
	</>
}
