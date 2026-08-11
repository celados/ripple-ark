import { useDialog } from '../../src/components';
import { Dialog } from '../../src/generated/dialog.tsrx';

// Regression fixture for the render prop's live-props contract (binding-runtime
// createRenderContent): pre-fix there was no render prop at all, so a consumer had no way
// to swap the trigger's element while keeping the machine's aria-haspopup/data-state attrs
// wired to it, nor to see those attrs update after open state changes without re-rendering.
export function RenderTrigger(props: { onReady: (dialog: ReturnType<typeof useDialog>) => void }) @{
	const dialog = useDialog({});
	props.onReady(dialog);
	<Dialog.RootProvider value={dialog}>
		<Dialog.Trigger
			render={(triggerProps) => <a {...triggerProps} data-testid="trigger" href="#">
				Open
			</a>}
		/>
	</Dialog.RootProvider>
}
