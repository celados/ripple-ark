import { Progress } from '../../src/generated/progress.tsrx';
import { Timer } from '../../src/generated/timer.tsrx';

// Regression fixture for derived-content fallbacks: pre-fix, Progress.ValueText and Timer.Item
// rendered `{children}` verbatim. Both parts are normally used with no children (the value is
// meant to come from machine state), so pre-fix they rendered empty.
export function DerivedContent() @{
	<>
		<Progress.Root defaultValue={50}>
			<Progress.ValueText data-testid="progress-value" />
		</Progress.Root>
		<Timer.Root startMs={0} targetMs={60000}>
			<Timer.Item type="seconds" data-testid="timer-seconds" />
		</Timer.Root>
	</>
}
