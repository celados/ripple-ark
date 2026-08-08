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
	'date-input': `export function SegmentContext(props: { render: (segment: AnyRecord) => Children }) @{
	const api = context.get();
	const groupProps = dateInputSegmentGroupProps.get();
	if (!api || !groupProps) throw new Error('DateInput.SegmentContext must be rendered inside SegmentGroup');
	const segments = track(() => api.value.getSegments(groupProps.value));
	@for (const segment of segments.value; index index) {
		const Content = () => props.render({ ...segment, index });
		<{Content} />
	}
}`,
	tour: `export function Actions(props: { render: (actions: Tracked<AnyRecord[]>) => Children }) @{
	const api = context.get();
	if (!api) throw new Error('Tour.Actions must be rendered inside Tour.Root');
	const actions = track(() => api.value.step?.actions ?? []);
	const Content = () => props.render(actions);
	<{Content} />
}`,
	'tree-view': `export function NodeProvider(props: ArkPartProps & { indexPath: number[]; node: unknown }) @{
	let &{ indexPath, node, children } = props;
	treeViewNodeProps.set(track(() => ({ indexPath, node })));
	{children}
}

export function NodeCheckboxIndicator(props: { children?: Children; indeterminate?: Children; fallback?: Children }) @{
	const api = context.get();
	const nodeProps = treeViewNodeProps.get();
	if (!api || !nodeProps) throw new Error('TreeView.NodeCheckboxIndicator must be rendered inside NodeProvider');
	const state = track(() => api.value.getNodeState(nodeProps.value as any));
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
	drawer: `const drawerStackStore = /*#__PURE__*/ new RippleContext<DrawerStack | null>(null);
const drawerStackApi = /*#__PURE__*/ new RippleContext<Tracked<AnyRecord> | null>(null);`,
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

function directGetterPropKeys(source: string, getter: string | undefined) {
	if (!getter) return [];
	const argument = source.match(new RegExp(`\\.${getter}\\(\\{([\\s\\S]*?)\\}\\)`))?.[1];
	if (!argument) return [];
	return [...argument.matchAll(/\bprops\.([A-Za-z_$][A-Za-z0-9_$]*)/g)].map((entry) => entry[1]);
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

const voidTags = new Set([
	'area',
	'base',
	'br',
	'col',
	'embed',
	'hr',
	'img',
	'input',
	'link',
	'meta',
	'param',
	'source',
	'track',
	'wbr',
]);

function staticElement(tag: string | undefined) {
	// A bare top-level expression is valid TypeScript but does not create a TSRX
	// render anchor, so rootless Ark providers would silently drop all children.
	if (!tag) return '<>{children}</>';
	return voidTags.has(tag)
		? `<${tag} {...mergedProps.value} />`
		: `<${tag} {...mergedProps.value}>{children}</${tag}>`;
}

function partDeclaration(part: {
	exportName: string;
	partName: string;
	tag: string;
	getter?: string;
	keys: string[];
	provide?: string;
	inherit?: string[];
}) {
	const inheritedVariables = part.inherit?.map(
		(name) => `${name[0].toLowerCase() + name.slice(1)}Props`
	);
	const fields = [
		`context`,
		part.getter ? `getter: '${part.getter}'` : undefined,
		part.keys.length ? `propKeys: ${literal(part.keys)}` : undefined,
		part.provide
			? `provideProps: ${part.provide[0].toLowerCase() + part.provide.slice(1)}Props`
			: undefined,
		inheritedVariables?.length === 1
			? `inheritedProps: ${inheritedVariables[0]}`
			: inheritedVariables?.length
				? `inheritedProps: [${inheritedVariables.join(', ')}]`
				: undefined,
	].filter(Boolean);
	return `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ ${fields.join(', ')} }, props);
	${staticElement(part.tag)}
}`;
}

function publicPartType(part: {
	partName: string;
	tag: string;
	getter?: string;
	keys: string[];
	inherit?: string[];
}) {
	const html = `ArkPartProps<'${part.tag}'>`;
	if (!part.getter) return html;
	const getter = `Api['${part.getter}']`;
	if (!part.inherit?.length) return `PartProps<'${part.tag}', ${getter}>`;
	if (!part.keys.length) return html;
	const keys = part.keys.map((key) => `'${key}'`).join(' | ');
	return `${html} & Pick<GetterProps<${getter}>, Extract<keyof GetterProps<${getter}>, ${keys}>>`;
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
		inherit?: string[];
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
		const inherited = [...source.matchAll(/\b(use\w+PropsContext)\(\)/g)].map((match) =>
			contextName(match[1])
		);
		const provide = provider
			? contextName(provider)
			: source.includes(`${componentName}ItemProvider value=`)
				? `${componentName}Item`
				: undefined;
		const inherit = [...new Set(inherited)];
		if (provide) contexts.add(provide);
		for (const inheritedContext of inherit) contexts.add(inheritedContext);
		const keys = [...new Set([...splitKeys(source), ...directGetterPropKeys(source, getter)])];
		parts.push({
			exportName,
			partName: namespaceName,
			tag,
			getter,
			keys,
			provide,
			inherit,
		});
	}

	const contextDeclarations = [...contexts]
		.map(
			(name) =>
				`const ${name[0].toLowerCase() + name.slice(1)}Props = /*#__PURE__*/ new RippleContext<Tracked<Record<string, any>> | null>(null);`
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
			return `export const ${alias} = /*#__PURE__*/ createItemContext(context, ${variable});`;
		})
		.join('\n');
	const partDeclarations = parts
		.map((part) => {
			if (directory.name === 'signature-pad' && part.partName === 'Segment') {
				return `export function Segment(props: SegmentProps) @{
	let &{ children } = props;
	const api = context.get();
	if (!api) throw new Error('SignaturePad.Segment must be rendered inside SignaturePad.Root');
	const mergedProps = usePartProps({ context, getter: 'getSegmentProps' }, props);
	<svg {...mergedProps.value}>
		<title>Signature</title>
		@for (const path of api.value.paths) {
			<path {...api.value.getSegmentPathProps({ path })} />
		}
		@if (api.value.currentPath) {
			<path {...api.value.getSegmentPathProps({ path: api.value.currentPath })} />
		}
		{children}
	</svg>
}`;
			}
			if (directory.name === 'drawer' && ['Indent', 'IndentBackground'].includes(part.partName)) {
				const getter = part.partName === 'Indent' ? 'getIndentProps' : 'getIndentBackgroundProps';
				return `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children } = props;
	const mergedProps = useExternalPartProps({ context: drawerStackApi, getter: '${getter}' }, props);
	<div {...mergedProps.value}>{children}</div>
}`;
			}
			return partDeclaration(part);
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
import { createApiContext, createItemContext, useExternalPartProps, usePartProps, useRootProps, useRootProviderProps, type ArkPartProps, type ComponentProps, type GetterProps, type PartProps } from '../binding-runtime.tsrx';

type Hook = typeof ${hook};
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
${specialPrelude[directory.name] ?? ''}
${contextDeclarations}

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps({
		context,
		configKeys: ${literal(configKeys)},
	${directory.name === 'drawer' ? 'defaultMachineProps: () => ({ stack: drawerStackStore.get() ?? undefined }),\n\t' : ''}
		useMachine: ${hook} as any,
	}, props);
	${staticElement(rootTag)}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	${staticElement(rootTag)}
}
${partDeclarations}
${itemContextDeclarations}
${specialDeclarations[directory.name] ?? ''}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ${rootTag ? `ArkPartProps<'${rootTag}'>` : 'ComponentProps'} & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ${rootTag ? `ArkPartProps<'${rootTag}'>` : 'ComponentProps'} & { value: ReturnType<Hook> };
${parts
	.map((part) => {
		// Drawer indentation belongs to the shared stack API, not to DrawerApi.
		// Keep its public surface honest instead of naming getters DrawerApi does not own.
		if (directory.name === 'drawer' && ['Indent', 'IndentBackground'].includes(part.partName)) {
			return `export type ${part.partName}Props = ArkPartProps<'div'>;`;
		}
		return `export type ${part.partName}Props = ${publicPartType(part)};`;
	})
	.join('\n')}

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
