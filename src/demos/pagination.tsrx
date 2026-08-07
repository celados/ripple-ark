import { usePagination } from '../index.ts';
import { LuChevronLeft, LuChevronRight } from '../internal/lucide-icons.tsrx';

export function Pagination() @{
	let api = usePagination({
		id: 'pagination',
		count: 1000,
	});

	<>
		@if (api.value.totalPages > 1) {
			<nav {...api.value.getRootProps()}>
				<ul role="pagination">
					<li>
						<a href="#previous" {...api.value.getPrevTriggerProps()}>
							<LuChevronLeft />

							<span>Previous Page</span>
						</a>
					</li>
					@for (const page of api.value.pages; index index) {
						@if (page.type === 'page') {
							<li>
								<a href={`#${page.value}`} {...api.value.getItemProps(page)}>{page.value}</a>
							</li>
						} @else {
							<li>
								<span {...api.value.getEllipsisProps({ index })}>
									...
								</span>
							</li>
						}
					}
					<li>
						<a href="#next" {...api.value.getNextTriggerProps()}>
							<LuChevronRight />

							<span>Next Page</span>
						</a>
					</li>
				</ul>
			</nav>
		}
	</>
}
