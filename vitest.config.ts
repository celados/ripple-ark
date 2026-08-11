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
		server: {
			deps: {
				// Vitest externalizes node_modules packages by default, so ripple-zag's dist
				// would import `ripple` through Node's own resolution (server build, its own
				// scheduler) while the mounted tree runs the vite-resolved browser build.
				// Machines then register their mount effect in a scheduler nothing flushes
				// and silently drop every event. Inlining routes ripple-zag through vite so
				// both sides share one ripple runtime.
				inline: [/@celados\/ripple-zag/],
			},
		},
	},
	resolve: {
		conditions: ['development', 'browser'],
		// Belt-and-braces with server.deps.inline: any nested/linked copy of ripple must
		// still collapse to the single vite-resolved instance, or `active_component` and
		// the effect scheduler split across realms.
		dedupe: ['ripple'],
	},
});
