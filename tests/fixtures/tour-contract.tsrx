import { useTour } from '../../src/components';
import { Tour } from '../../src/generated/tour.tsrx';

// Regression fixture for the Tour instance contract (tour.tsrx): pre-fix, Tour.Root ignored
// the `tour` prop and instead called useRootProps/useMachine itself, creating a second,
// disconnected tour machine. Calling `.start()` on the instance the consumer created (and
// handed to Root) never had any visible effect because Root's parts read a different instance.
export function TourContract(props: { onReady: (tour: ReturnType<typeof useTour>) => void }) @{
	const tour = useTour({
		steps: [
			{
				id: 'welcome',
				type: 'dialog',
				title: 'Welcome',
				description: 'This is the first step.',
			},
		],
	});
	props.onReady(tour);
	<Tour.Root tour={tour}>
		<Tour.Positioner>
			<Tour.Content data-testid="tour-content">
				<Tour.Title data-testid="tour-title" />
				<Tour.Description data-testid="tour-description" />
				<button>Next</button>
			</Tour.Content>
		</Tour.Positioner>
	</Tour.Root>
}
