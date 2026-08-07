import ripple from '@tsrx/eslint-plugin';

export default [
	{ ignores: ['.scratch/**', 'src/demos/sources.ts'] },
	...ripple.configs.recommended,
];
