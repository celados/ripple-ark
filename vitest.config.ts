import { ripple } from '@ripple-ts/vite-plugin';
import { defineConfig } from 'vitest/config';

// Mirrors @celados/ripple-zag's vitest setup (node_modules/@celados/ripple-zag/vite.config.ts):
// the 'browser' condition is required or ripple's package.json exports resolve to the
// server runtime (no DOM), which breaks `mount`; jsdom is the environment smoke tests mount into.
export default defineConfig({
	plugins: [ripple()],
	test: {
		retry: 2,
		globals: true,
		environment: 'jsdom',
		css: false,
	},
	resolve: {
		conditions: ['development', 'browser'],
		// @celados/ripple-zag is a linked workspace package with its own nested node_modules/ripple.
		// Without deduping, `useMachine`'s internal effect()/Context calls run against a second
		// `ripple` module instance whose `active_component` global never gets set by our mounted
		// tree, so every machine hook throws "effect() must be called within an active context".
		dedupe: ['ripple'],
	},
});
