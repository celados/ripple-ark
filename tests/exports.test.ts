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

	test('contains every demo moved from ripple-explore', () => {
		const demos = readdirSync('src/demos').filter(
			(file) => file.endsWith('.tsrx') && file !== 'index.tsrx'
		);
		const index = readFileSync('src/demos/index.tsrx', 'utf8');

		expect(demos).toHaveLength(49);
		for (const demo of demos) expect(index).toContain(`'./${demo}'`);
	});
});
