import { useDialog } from '../../src/components';
import { Dialog } from '../../src/generated/dialog.tsrx';

// Regression fixture for the presence layer (useRootPresence / PRESENCE_KEYS): pre-fix, Dialog
// had no presence wiring at all, so `lazyMount`/`unmountOnExit` were inert (Content always
// rendered) and leaked onto the root DOM element as plain props. Uses RootProvider + useDialog
// so the test can drive `api.setOpen()` imperatively instead of synthesizing pointer events.
export function PresenceDialog(props: {
	onReady: (dialog: ReturnType<typeof useDialog>) => void;
}) @{
	const dialog = useDialog({});
	props.onReady(dialog);
	<Dialog.RootProvider value={dialog} lazyMount unmountOnExit>
		<Dialog.Content data-testid="content">
			<button>Close</button>
		</Dialog.Content>
	</Dialog.RootProvider>
}
