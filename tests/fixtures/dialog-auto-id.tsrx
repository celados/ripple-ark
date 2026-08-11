import { Dialog } from '../../src/generated/dialog.tsrx';

// Regression fixture for auto id (create-machine.ts): pre-fix, createMachineHook called
// useMachine(machine, props) with no id injection, so an id-less Root fell through to zag's
// raw `ctx.id` interpolation as `undefined` — every id-less Root's Content collided on the
// same `dialog:undefined:content` id. Two Roots prove the per-instance counter, not just a
// hardcoded fallback, produces the id.
export function DialogAutoId() @{
	<>
		<Dialog.Root>
			<Dialog.Content data-testid="content-a">First</Dialog.Content>
		</Dialog.Root>
		<Dialog.Root>
			<Dialog.Content data-testid="content-b">Second</Dialog.Content>
		</Dialog.Root>
	</>
}
