import { mount, tick } from 'ripple';

// @zag-js/tour's trackBoundarySize effect reads the bare global `visualViewport` (not
// `window.visualViewport`) before falling back to `win.innerWidth`. jsdom never defines that
// global at all, so the bare reference throws ReferenceError instead of evaluating to
// `undefined`. This is a test-environment gap in jsdom, not an adapter bug — declaring the
// property (even as `undefined`) lets zag's own `?? win.innerWidth` / `?? win` fallbacks do
// their job the way they would in a real browser that has no visualViewport support.
if (typeof window !== 'undefined' && !('visualViewport' in window)) {
	(window as unknown as { visualViewport: undefined }).visualViewport = undefined;
}

// Same class of jsdom gap: @floating-ui/dom's autoUpdate constructs a ResizeObserver
// unconditionally, so every popper-backed machine (menu, popover, tooltip, select…) throws out of
// its trackPositioning effect and never writes the resolved --x/--y. A no-op observer is enough —
// jsdom reports zero-size rects anyway, so resize callbacks would carry nothing.
if (typeof globalThis.ResizeObserver === 'undefined') {
	globalThis.ResizeObserver = class {
		observe() {}
		unobserve() {}
		disconnect() {}
	} as unknown as typeof ResizeObserver;
}

// Mirrors @celados/ripple-zag's tests/render.ts renderMachine helper, adapted to mount a
// TSRX component tree (not a bare machine) and hand back a live DOM container.
export async function renderFixture(Component: any, props: Record<string, unknown> = {}) {
	const target = document.createElement('div');
	document.body.appendChild(target);

	const unmount = mount(Component, { target, props });
	await tick();

	return {
		target,
		unmount: () => {
			try {
				unmount();
			} catch {
				// Ripple's DOM removal may fail in jsdom
			}
			target.remove();
		},
	};
}

// Reactive updates from a machine action (context.set inside a watch/effect) land a tick or
// two after the triggering call, mirroring renderMachine's send() in ripple-zag: await tick(),
// then a microtask turn so queued effects that themselves schedule effects get to run.
export async function settle() {
	await tick();
	await Promise.resolve();
	await tick();
}

// @zag-js/presence's exit check runs inside a requestAnimationFrame callback (it reads
// getComputedStyle().animationName to decide whether to wait for a real CSS animation).
// jsdom has no animations, so the frame callback should unmount synchronously — but we still
// need a real frame to elapse before the machine's UNMOUNT event is sent.
export async function nextFrame() {
	await new Promise<void>((resolve) => requestAnimationFrame(() => resolve()));
	await settle();
}
