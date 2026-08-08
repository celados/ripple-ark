import { readFileSync, readdirSync } from 'node:fs';
import { describe, expect, test } from 'vitest';

type ManifestEntry = { directory: string; parts: string[] };

const generated = JSON.parse(
	readFileSync('src/generated/manifest.json', 'utf8')
) as ManifestEntry[];
const upstream = JSON.parse(
	readFileSync('src/generated/upstream-manifest.json', 'utf8')
) as ManifestEntry[];
const generatedByName = new Map(generated.map((entry) => [entry.directory, new Set(entry.parts)]));

const manualComponents = new Set([
	'client-only',
	'collection',
	'download-trigger',
	'field',
	'fieldset',
	'focus-trap',
	'format',
	'frame',
	'highlight',
	'json-tree-view',
	'presence',
	'swap',
	'toast',
]);

const typeOnlyAliases = new Set(['GenerateOptions', 'GenerateResult', 'Options', 'WaitOptions']);

describe('Ark UI upstream parity', () => {
	test('covers every official Solid component directory', () => {
		const missing = upstream
			.map((entry) => entry.directory)
			.filter((directory) => !generatedByName.has(directory) && !manualComponents.has(directory));

		expect(missing).toEqual([]);
		expect(upstream).toHaveLength(60);
	});

	test('generated namespaces include every official runtime part', () => {
		const missing = upstream.flatMap((entry) => {
			const actual = generatedByName.get(entry.directory);
			if (!actual) return [];
			return entry.parts
				.filter((part) => !typeOnlyAliases.has(part) && !actual.has(part))
				.map((part) => `${entry.directory}.${part}`);
		});

		expect(missing).toEqual([]);
	});

	test('generates native static tags instead of universal polymorphic parts', () => {
		const sources = readdirSync('src/generated')
			.filter((file) => file.endsWith('.tsrx'))
			.map((file) => readFileSync(`src/generated/${file}`, 'utf8'))
			.join('\n');

		// Render-prop contexts are the deliberate dynamic exception; machine parts
		// themselves must retain their generated native tags.
		expect(sources).not.toMatch(/<\{(?:as|dynamicTag)\}/);
		expect(sources).not.toContain('createPart(');
		expect(readFileSync('src/binding-runtime.tsrx', 'utf8')).not.toContain('as?:');
	});

	test('keeps generated component children reactive', () => {
		const sources = readdirSync('src/generated')
			.filter((file) => file.endsWith('.tsrx'))
			.map((file) => readFileSync(`src/generated/${file}`, 'utf8'))
			.join('\n');

		expect(sources).not.toContain('const children = props.children');
		expect(sources).toContain('let &{ children } = props');
	});

	test('forwards direct Solid getter props to Zag', () => {
		const imageCropper = readFileSync('src/generated/image-cropper.tsrx', 'utf8');

		expect(imageCropper).toContain("getter: 'getHandleProps'");
		expect(imageCropper).toMatch(/getHandleProps'[\s\S]*?propKeys:\s*\[\s*["']position["']/);
		expect(imageCropper).toMatch(/getGridProps'[\s\S]*?propKeys:\s*\[\s*["']axis["']/);
	});

	test('renders children for rootless Ark providers', () => {
		const dialog = readFileSync('src/generated/dialog.tsrx', 'utf8');

		expect(dialog).toMatch(/<>\s*\{children\}\s*<\/>/);
	});
});
