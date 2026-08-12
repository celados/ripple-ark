import { MenuControlledOpen, type ControlledHandle } from './fixtures/menu-controlled-open.tsrx';
import { MenuControlledOpenRaw } from './fixtures/menu-controlled-open-raw.tsrx';
import { MenuDismissable } from './fixtures/menu-dismissable.tsrx';
import { MenuWithStandingLayer } from './fixtures/menu-with-standing-layer.tsrx';
import { nextFrame, renderFixture, settle } from './render';

// Issue #6: the two paths where a machine must react to something other than a user event —
// a controlled prop changing, and a dismissable layer installed from a state-entry effect.

describe('controlled open prop (issue #6)', () => {
	test('outside writes to a controlled `open` drive the machine both ways', async () => {
		let handle!: ControlledHandle;
		const { target, unmount } = await renderFixture(MenuControlledOpen, {
			onReady: (h: ControlledHandle) => {
				handle = h;
			},
		});

		try {
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;
			expect(content.getAttribute('data-state')).toBe('closed');

			handle.setOpen(true);
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('open');

			handle.setOpen(false);
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('closed');
		} finally {
			unmount();
		}
	});

	// The reported sequence: the machine moves first on a user event, and only then does the
	// controlled prop have to close it. Driving the prop from the initial state is a different
	// path — the watcher's previous deps have not been advanced by a machine-initiated change.
	test('a controlled `open` closes a menu that was opened by its trigger', async () => {
		let handle!: ControlledHandle;
		const { target, unmount } = await renderFixture(MenuControlledOpen, {
			onReady: (h: ControlledHandle) => {
				handle = h;
			},
		});

		try {
			const trigger = target.querySelector('[data-testid="trigger"]') as HTMLElement;
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;

			trigger.click();
			await settle();
			await nextFrame();
			expect(handle.changes).toContain(true);
			expect(handle.getOpen()).toBe(true);
			expect(content.getAttribute('data-state')).toBe('open');

			handle.setOpen(false);
			await settle();
			await nextFrame();
			expect(handle.getOpen()).toBe(false);
			expect(content.getAttribute('data-state')).toBe('closed');
		} finally {
			unmount();
		}
	});

	test('a raw-value `open` drives the machine the same way a Tracked box does', async () => {
		let handle!: ControlledHandle;
		const { target, unmount } = await renderFixture(MenuControlledOpenRaw, {
			onReady: (h: ControlledHandle) => {
				handle = h;
			},
		});

		try {
			const trigger = target.querySelector('[data-testid="trigger"]') as HTMLElement;
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;

			trigger.click();
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('open');

			handle.setOpen(false);
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('closed');

			handle.setOpen(true);
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('open');
		} finally {
			unmount();
		}
	});
});

describe('dismissable layer (issue #6)', () => {
	// Entering "open" from a transition installs the state-entry effects from inside the click
	// handler, before Ripple has flushed the DOM — a different path from entering "open" at mount.
	test('Escape closes a menu opened by its trigger', async () => {
		const onEscapeKeyDown = vi.fn();
		const { target, unmount } = await renderFixture(MenuDismissable, {
			onEscapeKeyDown,
			defaultOpen: false,
		});

		try {
			const trigger = target.querySelector('[data-testid="trigger"]') as HTMLElement;
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;

			trigger.click();
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('open');

			document.dispatchEvent(new KeyboardEvent('keydown', { key: 'Escape', bubbles: true }));
			await settle();
			await nextFrame();

			expect(onEscapeKeyDown).toHaveBeenCalled();
			expect(content.getAttribute('data-state')).toBe('closed');
		} finally {
			unmount();
		}
	});

	test('Escape closes an open menu and calls onEscapeKeyDown', async () => {
		const onEscapeKeyDown = vi.fn();
		const onOpenChange = vi.fn();
		const { target, unmount } = await renderFixture(MenuDismissable, {
			onEscapeKeyDown,
			onOpenChange,
		});

		try {
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;
			expect(content.getAttribute('data-state')).toBe('open');

			// trackDismissableElement defers its listener install to a frame (defer: true).
			await nextFrame();

			document.dispatchEvent(
				new KeyboardEvent('keydown', { key: 'Escape', bubbles: true })
			);
			await settle();
			await nextFrame();

			expect(onEscapeKeyDown).toHaveBeenCalled();
			expect(onOpenChange).toHaveBeenCalledWith(expect.objectContaining({ open: false }));
			expect(content.getAttribute('data-state')).toBe('closed');
		} finally {
			unmount();
		}
	});

	test('outside pointerdown closes an open menu and calls onInteractOutside', async () => {
		const onInteractOutside = vi.fn();
		const onOpenChange = vi.fn();
		const { target, unmount } = await renderFixture(MenuDismissable, {
			onInteractOutside,
			onOpenChange,
		});

		const outside = document.createElement('button');
		document.body.appendChild(outside);

		try {
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;
			await nextFrame();

			outside.dispatchEvent(new PointerEvent('pointerdown', { bubbles: true }));
			outside.dispatchEvent(new PointerEvent('pointerup', { bubbles: true }));
			await settle();
			await nextFrame();

			expect(onInteractOutside).toHaveBeenCalled();
			expect(onOpenChange).toHaveBeenCalledWith(expect.objectContaining({ open: false }));
			expect(content.getAttribute('data-state')).toBe('closed');
		} finally {
			outside.remove();
			unmount();
		}
	});

	test('Escape still closes the menu when a standing dismissable layer is mounted', async () => {
		const onEscapeKeyDown = vi.fn();
		const { target, unmount } = await renderFixture(MenuWithStandingLayer, { onEscapeKeyDown });

		try {
			const trigger = target.querySelector('[data-testid="trigger"]') as HTMLElement;
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;
			expect(target.querySelector('[data-testid="standing-layer"]')).not.toBeNull();

			trigger.click();
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('open');

			document.dispatchEvent(new KeyboardEvent('keydown', { key: 'Escape', bubbles: true }));
			await settle();
			await nextFrame();

			expect(onEscapeKeyDown).toHaveBeenCalled();
			expect(content.getAttribute('data-state')).toBe('closed');
		} finally {
			unmount();
		}
	});

	// Characterizes @zag-js/dismissable's layer-stack contract, which is framework-agnostic and
	// therefore identical under Ark's React/Solid bindings: `dismissable-layer.mjs` gates
	// onEscapeKeyDown on `layerStack.isTopMost(node)`, but gates outside-press only on
	// `isBelowPointerBlockingLayer` (modal layers). So a non-modal layer that mounts above an open
	// menu — e.g. a permanently-open Popover — deafens Escape for it while leaving outside-press
	// working. This is composition behavior to design around, not an adapter defect.
	test('a layer mounted above the open menu deafens Escape but not outside press', async () => {
		const onEscapeKeyDown = vi.fn();
		const onInteractOutside = vi.fn();
		let handle!: { showLayer(value: boolean): void };
		const { target, unmount } = await renderFixture(MenuWithStandingLayer, {
			initialLayer: false,
			onEscapeKeyDown,
			onInteractOutside,
			onReady: (h: { showLayer(value: boolean): void }) => {
				handle = h;
			},
		});

		const outside = document.createElement('button');
		document.body.appendChild(outside);

		try {
			const trigger = target.querySelector('[data-testid="trigger"]') as HTMLElement;
			const content = target.querySelector('[data-testid="content"]') as HTMLElement;

			trigger.click();
			await settle();
			await nextFrame();
			expect(content.getAttribute('data-state')).toBe('open');

			handle.showLayer(true);
			await settle();
			await nextFrame();
			expect(target.querySelector('[data-testid="standing-layer"]')).not.toBeNull();

			document.dispatchEvent(new KeyboardEvent('keydown', { key: 'Escape', bubbles: true }));
			await settle();
			await nextFrame();
			expect(onEscapeKeyDown).not.toHaveBeenCalled();
			expect(content.getAttribute('data-state')).toBe('open');

			outside.dispatchEvent(new PointerEvent('pointerdown', { bubbles: true }));
			outside.dispatchEvent(new PointerEvent('pointerup', { bubbles: true }));
			await settle();
			await nextFrame();
			expect(onInteractOutside).toHaveBeenCalled();
			expect(content.getAttribute('data-state')).toBe('closed');
		} finally {
			outside.remove();
			unmount();
		}
	});

	test('the positioner receives popper positioning styles while open', async () => {
		const { target, unmount } = await renderFixture(MenuDismissable, {});

		try {
			const positioner = target.querySelector('[data-testid="positioner"]') as HTMLElement;
			await nextFrame();

			// `--x`/`--y` are written by trackPositioning's update callback, not by the static
			// positioner props — asserting `position: absolute` would pass even with a dead machine.
			expect(positioner.style.getPropertyValue('--x')).not.toBe('');
		} finally {
			unmount();
		}
	});
});
