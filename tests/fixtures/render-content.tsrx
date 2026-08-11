import { useDialog } from '../../src/components';
import { Dialog } from '../../src/generated/dialog.tsrx';

// Regression fixture for the presence-ref contract (binding-runtime createRenderContent +
// the generator's createRefKey-symbol composed ref, see .agents/skills/upstream-sync ref
// verification): pre-fix there was no render prop, so a presence-gated part had no way to
// swap its element at all, and — the part this fixture actually targets — a render
// consumer that just spreads `{...props}` onto a plain element (no special ref handling)
// still needs the presence machine's setNode + the caller's own `ref` prop to both fire off
// the same DOM node, and both fire null again once the gate unmounts it.
export function RenderContent(props: {
	onReady: (dialog: ReturnType<typeof useDialog>) => void;
	onRef: (node: HTMLElement | null) => void;
}) @{
	const dialog = useDialog({});
	props.onReady(dialog);
	<Dialog.RootProvider value={dialog} lazyMount unmountOnExit>
		<Dialog.Content
			ref={props.onRef}
			render={(contentProps) => <section {...contentProps} data-testid="content">
				Body
			</section>}
		/>
	</Dialog.RootProvider>
}
