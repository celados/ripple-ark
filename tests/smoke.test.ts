import { describe, expect, test, vi } from 'vitest';

import type { useDialog, useTour } from '../src/components';
import { CheckboxGroupSmoke } from './fixtures/checkbox-group.tsrx';
import { DerivedContent } from './fixtures/derived-content.tsrx';
import { DialogAutoId } from './fixtures/dialog-auto-id.tsrx';
import { MenuOnSelect } from './fixtures/menu-on-select.tsrx';
import { PresenceDialog } from './fixtures/presence-dialog.tsrx';
import { RenderContent } from './fixtures/render-content.tsrx';
import { RenderTrigger } from './fixtures/render-trigger.tsrx';
import { SelectCollection } from './fixtures/select-collection.tsrx';
import { TourContract } from './fixtures/tour-contract.tsrx';
import { nextFrame, renderFixture, settle } from './render';

// Behavioral gate for the structural fixes described in .scratch/fix-specs: namespace parity,
// typecheck, and the SSR pack (tests/exports.test.ts, scripts/check-package.mjs) all check
// names and types, never runtime behavior, which is how v0.3.2 shipped dead components. Every
// assertion below reproduces the pre-fix failure mode it guards against (see fixture comments).

describe('auto id (issue #2)', () => {
	test('id-less Dialog.Root instances mount and each Content gets a distinct id', async () => {
		// Pre-fix: createMachineHook forwarded raw props straight to useMachine with no id
		// injection, so every id-less Root's Content collided on the same
		// `dialog:undefined:content` id instead of getting a distinct one.
		const { target, unmount } = await renderFixture(DialogAutoId);
		try {
			const a = target.querySelector('[data-testid="content-a"]') as HTMLElement;
			const b = target.querySelector('[data-testid="content-b"]') as HTMLElement;
			expect(a.id).toBeTruthy();
			expect(b.id).toBeTruthy();
			expect(a.id).not.toBe(b.id);
		} finally {
			unmount();
		}
	});
});

describe('Select revived (configKeys)', () => {
	test('collection + defaultValue reach the machine, and machine-only props stay off the DOM', async () => {
		const { target, unmount } = await renderFixture(SelectCollection);
		try {
			const root = target.querySelector('[data-testid="select-root"]') as HTMLElement;
			const valueText = target.querySelector('[data-testid="select-value-text"]') as HTMLElement;

			// Pre-fix: Select.Root's configKeys was `[]`, so `collection`/`defaultValue` never
			// reached the machine — the trigger showed the placeholder, not the selected label.
			expect(valueText.textContent).toBe('Apple');

			// Pre-fix: with configKeys empty, every prop (including lazyMount and the collection
			// object itself) fell into localProps and was spread onto the root DOM element.
			expect(root.hasAttribute('lazymount')).toBe(false);
			expect(root.hasAttribute('lazyMount')).toBe(false);
			expect(root.hasAttribute('collection')).toBe(false);
			expect(root.hasAttribute('onvaluechange')).toBe(false);
		} finally {
			unmount();
		}
	});
});

describe('Menu.Item onSelect (issue #3)', () => {
	test('selecting an item via pointerdown+click fires the onSelect callback', async () => {
		const onSelect = vi.fn();
		// Pre-fix: onSelect was accepted as a prop but never read off the item and no
		// addItemListener effect existed, so this spy would never fire no matter what was
		// dispatched at the item element.
		const { target, unmount } = await renderFixture(MenuOnSelect, { onSelect });
		try {
			const item = target.querySelector('[data-value="opt"]') as HTMLElement;
			expect(item).toBeTruthy();

			// zag's getItemProps highlights the item on pointerdown, then ITEM_CLICK's
			// invokeOnSelect action reads the highlighted item and dispatches menu's custom
			// `menu:select` DOM event on it — addItemListener is what turns that into onSelect.
			item.dispatchEvent(new Event('pointerdown', { bubbles: true }));
			await settle();
			item.dispatchEvent(new MouseEvent('click', { bubbles: true }));
			await settle();

			expect(onSelect).toHaveBeenCalledTimes(1);
		} finally {
			unmount();
		}
	});
});

describe('Presence (lazyMount / unmountOnExit)', () => {
	test('lazyMount defers the first mount and unmountOnExit removes Content again on close', async () => {
		let dialog: ReturnType<typeof useDialog> | undefined;
		// Pre-fix: Dialog had no presence wiring, so lazyMount/unmountOnExit were inert (Content
		// was always in the DOM) and leaked onto the root element as plain, meaningless props.
		const { target, unmount } = await renderFixture(PresenceDialog, {
			onReady: (api: ReturnType<typeof useDialog>) => {
				dialog = api;
			},
		});
		try {
			expect(target.querySelector('[data-testid="content"]')).toBeNull();

			dialog!.value.setOpen(true);
			await settle();
			expect(target.querySelector('[data-testid="content"]')).not.toBeNull();

			dialog!.value.setOpen(false);
			// Let the presence machine's watch register its exit-check raf callback, then let
			// that frame elapse — @zag-js/presence checks getComputedStyle().animationName and,
			// since jsdom reports no animation, unmounts synchronously inside the frame.
			await settle();
			await nextFrame();
			expect(target.querySelector('[data-testid="content"]')).toBeNull();
		} finally {
			unmount();
		}
	});
});

describe('Checkbox.Group', () => {
	test('group state drives each checkbox and toggling one updates its own checked state', async () => {
		// Pre-fix: Group rendered via usePartProps against the checkbox Root's own api context,
		// which doesn't exist around a Group — mounting this tree threw "Ark part must be
		// rendered inside its Root or RootProvider".
		const { target, unmount } = await renderFixture(CheckboxGroupSmoke);
		try {
			const inputA = target.querySelector('[data-testid="checkbox-a"] input') as HTMLInputElement;
			const inputB = target.querySelector('[data-testid="checkbox-b"] input') as HTMLInputElement;

			expect(inputA.checked).toBe(true);
			expect(inputB.checked).toBe(false);

			inputB.click();
			await settle();

			expect(inputB.checked).toBe(true);
		} finally {
			unmount();
		}
	});
});

describe('Tour instance contract', () => {
	test('Root renders the externally-created tour instance, and starting it populates Title', async () => {
		let tour: ReturnType<typeof useTour> | undefined;
		// Pre-fix: Root ignored the `tour` prop and called useRootProps/useMachine itself,
		// creating a second, disconnected machine — calling .start() on the instance the
		// consumer created (and handed to Root) had no visible effect on what Root rendered.
		const { target, unmount } = await renderFixture(TourContract, {
			onReady: (t: ReturnType<typeof useTour>) => {
				tour = t;
			},
		});
		try {
			const title = target.querySelector('[data-testid="tour-title"]') as HTMLElement;
			expect(title.textContent).not.toBe('Welcome');

			tour!.value.start();
			await settle();

			expect(title.textContent).toBe('Welcome');
		} finally {
			unmount();
		}
	});
});

describe('Derived content fallbacks', () => {
	test('Progress.ValueText and Timer.Item render machine-derived text with no children', async () => {
		// Pre-fix: both parts rendered `{children}` verbatim; neither is normally given
		// children (the value is meant to come from machine state), so both rendered empty.
		const { target, unmount } = await renderFixture(DerivedContent);
		try {
			const progressValue = target.querySelector('[data-testid="progress-value"]') as HTMLElement;
			const timerSeconds = target.querySelector('[data-testid="timer-seconds"]') as HTMLElement;

			expect(progressValue.textContent).toMatch(/\d/);
			expect(progressValue.textContent).toMatch(/%$/);
			expect(timerSeconds.textContent).toMatch(/^\d+$/);
		} finally {
			unmount();
		}
	});
});

describe('Composition: render prop (Base UI function form, not asChild)', () => {
	test('Dialog.Trigger render swaps the element but keeps it wired to live machine state', async () => {
		// Pre-fix: there was no render prop at all — a custom trigger element had no way to
		// receive the machine's aria-haspopup/data-state attrs, headless or otherwise.
		let dialog: ReturnType<typeof useDialog> | undefined;
		const { target, unmount } = await renderFixture(RenderTrigger, {
			onReady: (api: ReturnType<typeof useDialog>) => {
				dialog = api;
			},
		});
		try {
			const trigger = target.querySelector('[data-testid="trigger"]') as HTMLAnchorElement;
			expect(trigger.tagName).toBe('A');
			expect(trigger.getAttribute('aria-haspopup')).toBe('dialog');
			expect(trigger.getAttribute('data-state')).toBe('closed');
			// render itself must never leak onto the DOM as a literal attribute.
			expect(trigger.hasAttribute('render')).toBe(false);

			// Proves liveness through createRenderContent's proxy, not just a one-shot read:
			// the render callback ran once, but reading `data-state` off its return value
			// must still track the machine after open state changes.
			dialog!.value.setOpen(true);
			await settle();

			expect(trigger.getAttribute('data-state')).toBe('open');
		} finally {
			unmount();
		}
	});

	test('presence-gated Dialog.Content render mounts/unmounts with the gate and composes setNode with the caller ref', async () => {
		// Pre-fix: no render prop, so a presence-gated part had no swap mechanism at all —
		// this also exercises the verified ref contract (#3 in 04-render-migration.md): the
		// presence machine's setNode and the caller's own `ref` prop are composed under one
		// createRefKey() symbol, so a plain `{...contentProps}` spread onto an arbitrary
		// custom element (no special ref handling on the consumer's part) still gets both to
		// fire on the same DOM node.
		let dialog: ReturnType<typeof useDialog> | undefined;
		const refCalls: Array<HTMLElement | null> = [];
		const { target, unmount } = await renderFixture(RenderContent, {
			onReady: (api: ReturnType<typeof useDialog>) => {
				dialog = api;
			},
			onRef: (node: HTMLElement | null) => {
				refCalls.push(node);
			},
		});
		try {
			// lazyMount: closed on first render, so the render branch never mounted.
			expect(target.querySelector('[data-testid="content"]')).toBeNull();
			expect(refCalls).toEqual([]);

			dialog!.value.setOpen(true);
			await settle();

			const content = target.querySelector('[data-testid="content"]') as HTMLElement;
			expect(content).toBeTruthy();
			expect(content.tagName).toBe('SECTION');
			// Ripple's ref binder wraps a callback ref in an effect (verified against
			// .scratch/ripple-upstream/packages/ripple/src/runtime/internal/client/blocks.js
			// — ref()'s own doc comment: "invoked with the element on mount; if it returns a
			// function, that function runs as the cleanup on unmount"), so a callback that
			// itself reads a reactive value (applyPresenceRef reads presence.value) can
			// re-fire more than once — every call here must still land on the same live node.
			expect(refCalls.length).toBeGreaterThan(0);
			expect(refCalls.every((node) => node === content)).toBe(true);

			dialog!.value.setOpen(false);
			await settle();
			await nextFrame();

			// unmountOnExit: the gate tore the render branch back down. A callback ref that
			// never returns a cleanup function (ours doesn't) is never re-invoked with
			// `null` on unmount — see the ref() doc comment above — so the DOM node
			// actually disappearing is the correct proof the gate unmounted the render
			// branch, not a trailing `null` ref call.
			expect(target.querySelector('[data-testid="content"]')).toBeNull();
		} finally {
			unmount();
		}
	});
});
