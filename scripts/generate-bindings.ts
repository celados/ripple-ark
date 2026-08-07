import { mkdirSync, readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { basename, join } from 'node:path';

const upstreamRoot = process.env.ARK_UPSTREAM_DIR ?? '.scratch/ark-upstream';
const solidComponents = join(upstreamRoot, 'packages/solid/src/components');
const outputRoot = 'src/generated';

const hookOverrides: Record<string, string> = {
	'segment-group': 'useRadioGroup',
};

const skipped = new Set([
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

const specialDeclarations: Record<string, string> = {
	drawer: `export function Stack(props: { children?: Children | Children[] }) @{
	const store = createStack();
	const revision = track(0);
	effect(() => store.subscribe(() => { revision.value += 1; }));
	const api = track(() => {
		revision.value;
		return connectStack(store.getSnapshot(), normalizeProps) as AnyRecord;
	});
	drawerStackStore.set(store);
	drawerStackApi.set(api);
	{props.children}
}`,
	'date-input': `export function SegmentContext(props: { children: (segment: AnyRecord) => Children }) @{
	const api = context.get();
	const groupProps = dateInputSegmentGroupProps.get();
	if (!api || !groupProps) throw new Error('DateInput.SegmentContext must be rendered inside SegmentGroup');
	const segments = track(() => api.value.getSegments(groupProps));
	const render = props.children;
	@for (const segment of segments.value; index index) {
		<>{render({ ...segment, index })}</>
	}
}`,
	tour: `export function Actions(props: { children: (actions: Tracked<AnyRecord[]>) => Children }) @{
	const api = context.get();
	if (!api) throw new Error('Tour.Actions must be rendered inside Tour.Root');
	const actions = track(() => api.value.step?.actions ?? []);
	const render = props.children;
	{render(actions)}
}`,
	'tree-view': `export function NodeProvider(props: ArkPartProps & { indexPath: number[]; node: unknown }) @{
	const { indexPath, node, children } = props;
	treeViewNodeProps.set({ indexPath, node });
	{children}
}

export function NodeCheckboxIndicator(props: { children?: Children; indeterminate?: Children; fallback?: Children }) @{
	const api = context.get();
	const nodeProps = treeViewNodeProps.get();
	if (!api || !nodeProps) throw new Error('TreeView.NodeCheckboxIndicator must be rendered inside NodeProvider');
	const state = track(() => api.value.getNodeState(nodeProps as any));
	@if (state.value.checked === 'indeterminate' && props.indeterminate) {
		{props.indeterminate}
	} @else if (state.value.checked === true && props.children) {
		{props.children}
	} @else {
		{props.fallback}
	}
}`,
};

const specialPrelude: Record<string, string> = {
	drawer: `const drawerStackStore = new RippleContext<DrawerStack | null>(null);
const drawerStackApi = new RippleContext<Tracked<AnyRecord> | null>(null);`,
};

const specialNames: Record<string, string[]> = {
	drawer: ['Stack'],
	'date-input': ['SegmentContext'],
	tour: ['Actions'],
	'tree-view': ['NodeProvider', 'NodeCheckboxIndicator'],
};

const extraImports: Record<string, string> = {
	drawer: `import { connectStack, createStack, type DrawerStack } from '@zag-js/drawer';
import { normalizeProps } from '@celados/ripple-zag';`,
};

function pascalCase(value: string) {
	return value
		.split('-')
		.map((part) => part[0].toUpperCase() + part.slice(1))
		.join('');
}

function splitKeys(source: string) {
	const match = source.match(/createSplitProps<[^>]+>\(\)\([^,]+,\s*\[([\s\S]*?)\]\)/);
	return match ? [...match[1].matchAll(/['"]([^'"]+)['"]/g)].map((entry) => entry[1]) : [];
}

function contextName(value: string) {
	return value
		.replace(/^use/, '')
		.replace(/PropsContext$/, '')
		.replace(/PropsProvider$/, '');
}

function literal(value: unknown) {
	return JSON.stringify(value, null, '\t');
}

mkdirSync(outputRoot, { recursive: true });

const generated: { directory: string; symbol: string; parts: string[] }[] = [];

for (const directory of readdirSync(solidComponents, { withFileTypes: true })) {
	if (!directory.isDirectory() || skipped.has(directory.name)) continue;
	const componentName = pascalCase(directory.name);
	const componentRoot = join(solidComponents, directory.name);
	const namespaceSource = readFileSync(join(componentRoot, `${directory.name}.ts`), 'utf8');
	const rootPath = join(componentRoot, `${directory.name}-root.tsx`);
	let rootSource: string;
	try {
		rootSource = readFileSync(rootPath, 'utf8');
	} catch {
		continue;
	}

	const hook = hookOverrides[directory.name] ?? `use${componentName}`;
	const rootTag = rootSource.match(/<ark\.([a-z][a-z0-9]*)/)?.[1];
	const configKeys = splitKeys(rootSource);
	const parts: {
		exportName: string;
		partName: string;
		tag: string;
		getter?: string;
		keys: string[];
		provide?: string;
		inherit?: string;
	}[] = [];
	const contexts = new Set<string>();

	for (const entry of readdirSync(componentRoot, { withFileTypes: true })) {
		if (!entry.isFile()) continue;
		const file = entry.name;
		if (!file.endsWith('.tsx')) continue;
		if (/\.(stories|test)\.tsx$/.test(file) || file.endsWith('.anatomy.tsx')) continue;
		if (file === `${directory.name}-root.tsx` || file === `${directory.name}-root-provider.tsx`)
			continue;
		const source = readFileSync(join(componentRoot, file), 'utf8');
		const exportName = source.match(/export const (\w+)\s*=/)?.[1];
		if (!exportName || exportName.endsWith('Context')) continue;
		const namespaceName = namespaceSource.match(
			new RegExp(`\\b${exportName}\\s+as\\s+(\\w+)`)
		)?.[1];
		if (!namespaceName) continue;
		const tag =
			source.match(/<ark\.([a-z][a-z0-9]*)/)?.[1] ??
			source.match(/PolymorphicProps<'([a-z][a-z0-9]*)'>/)?.[1];
		if (!tag) continue;
		const getter =
			source.match(/mergeProps\([\s\S]*?\.(get[A-Z][A-Za-z0-9]+Props)\(/)?.[1] ??
			source.match(/\.(get[A-Z][A-Za-z0-9]+Props)\(/)?.[1];
		const provider = source.match(/<(\w+PropsProvider)\s+value=/)?.[1];
		const inherited = source.match(/\b(use\w+PropsContext)\(\)/)?.[1];
		const provide = provider
			? contextName(provider)
			: source.includes(`${componentName}ItemProvider value=`)
				? `${componentName}Item`
				: undefined;
		const inherit = inherited ? contextName(inherited) : undefined;
		if (provide) contexts.add(provide);
		if (inherit) contexts.add(inherit);
		parts.push({
			exportName,
			partName: namespaceName,
			tag,
			getter,
			keys: splitKeys(source),
			provide,
			inherit,
		});
	}

	const contextDeclarations = [...contexts]
		.map(
			(name) =>
				`const ${name[0].toLowerCase() + name.slice(1)}Props = new RippleContext<Record<string, any> | null>(null);`
		)
		.join('\n');
	const itemContextDeclarations = [...contexts]
		.map((name) => ({
			name,
			alias: namespaceSource.match(new RegExp(`\\b${name}Context\\s+as\\s+(\\w+)`))?.[1],
		}))
		.filter((entry): entry is { name: string; alias: string } => Boolean(entry.alias))
		.map(({ name, alias }) => {
			const variable = `${name[0].toLowerCase() + name.slice(1)}Props`;
			return `export const ${alias} = createItemContext(context, ${variable});`;
		})
		.join('\n');
	const partDeclarations = parts
		.map((part) => {
			if (directory.name === 'drawer' && ['Indent', 'IndentBackground'].includes(part.partName)) {
				const getter = part.partName === 'Indent' ? 'getIndentProps' : 'getIndentBackgroundProps';
				return `export const ${part.partName} = createExternalPart({ context: drawerStackApi, defaultTag: 'div', getter: '${getter}' });`;
			}
			const fields = [
				`context`,
				`defaultTag: '${part.tag}'`,
				part.getter ? `getter: '${part.getter}'` : undefined,
				part.keys.length ? `propKeys: ${literal(part.keys)}` : undefined,
				part.provide
					? `provideProps: ${part.provide[0].toLowerCase() + part.provide.slice(1)}Props`
					: undefined,
				part.inherit
					? `inheritedProps: ${part.inherit[0].toLowerCase() + part.inherit.slice(1)}Props`
					: undefined,
			].filter(Boolean);
			return `export const ${part.partName} = createPart({ ${fields.join(', ')} });`;
		})
		.join('\n');
	const itemContextNames = [...contexts]
		.map((name) => namespaceSource.match(new RegExp(`\\b${name}Context\\s+as\\s+(\\w+)`))?.[1])
		.filter((name): name is string => Boolean(name));
	const namespaceParts = [
		'Root',
		'RootProvider',
		...parts.map((part) => part.partName),
		...itemContextNames,
		...(specialNames[directory.name] ?? []),
		'Context',
	];
	const source = `import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';
${extraImports[directory.name] ?? ''}
import { ${hook} } from '../components';
import { createApiContext, createExternalPart, createItemContext, createPart, createRoot, createRootProvider, type ArkPartProps } from '../binding-runtime.tsrx';

type Hook = typeof ${hook};
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);
${specialPrelude[directory.name] ?? ''}
${contextDeclarations}

export const Root = createRoot({
	context,
	${rootTag ? `defaultTag: '${rootTag}',\n\t` : ''}configKeys: ${literal(configKeys)},
	${directory.name === 'drawer' ? 'defaultMachineProps: () => ({ stack: drawerStackStore.get() ?? undefined }),\n\t' : ''}
	useMachine: ${hook} as any,
});
export const RootProvider = createRootProvider({ context${rootTag ? `, defaultTag: '${rootTag}'` : ''} });
${partDeclarations}
${itemContextDeclarations}
${specialDeclarations[directory.name] ?? ''}
export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
${parts.map((part) => `export type ${part.partName}Props = ArkPartProps;`).join('\n')}

export const ${componentName} = { ${namespaceParts.join(', ')} };
`;

	writeFileSync(join(outputRoot, `${directory.name}.tsrx`), source);
	generated.push({ directory: directory.name, symbol: componentName, parts: namespaceParts });
}

writeFileSync(
	join(outputRoot, 'index.ts'),
	[
		...generated.map((entry) => `export { ${entry.symbol} } from './${entry.directory}.tsrx';`),
		"export { CascadeSelect } from './cascade-select.tsrx';",
		"export { Presence } from './presence.tsrx';",
	].join('\n') + '\n'
);
writeFileSync(join(outputRoot, 'manifest.json'), JSON.stringify(generated, null, 2) + '\n');

const upstreamManifest = readdirSync(solidComponents, { withFileTypes: true })
	.filter((entry) => entry.isDirectory())
	.map((entry) => {
		let source = '';
		try {
			source = readFileSync(join(solidComponents, entry.name, `${entry.name}.ts`), 'utf8');
		} catch {
			return { directory: entry.name, parts: [] };
		}
		const parts = [...source.matchAll(/export\s+(type\s+)?\{([\s\S]*?)\}\s+from/g)]
			.filter((match) => !match[1])
			.flatMap((match) => [
				...match[2].matchAll(/^(?!\s*type\b)[^\n]*?\b(?:as\s+)([A-Z][A-Za-z0-9]+)(?:,|\s*$)/gm),
			])
			.map((match) => match[1]);
		return { directory: entry.name, parts: [...new Set(parts)] };
	});
writeFileSync(
	join(outputRoot, 'upstream-manifest.json'),
	JSON.stringify(upstreamManifest, null, 2) + '\n'
);
writeFileSync(
	'tests/fixtures/all-components.ts',
	generated
		.map(
			(entry) =>
				`import { ${entry.symbol} } from '@celados/ripple-ark/${entry.directory}';\nvoid ${entry.symbol};`
		)
		.join('\n') + '\n'
);

console.log(`Generated ${generated.length} Ripple component bindings in ${outputRoot}`);
