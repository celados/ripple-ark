import { mkdirSync, readdirSync, readFileSync, writeFileSync } from 'node:fs';
import { basename, join } from 'node:path';

const upstreamRoot = process.env.ARK_UPSTREAM_DIR ?? '.scratch/ark-upstream';
const solidComponents = join(upstreamRoot, 'packages/solid/src/components');
const outputRoot = 'src/generated';

const hookOverrides: Record<string, string> = {
	'segment-group': 'useRadioGroup',
};

// zag-props gate: machine package name per directory. Mirrors hookOverrides
// (segment-group composes radio-group's machine) — kept separate because the
// hook name and the npm package name are cased differently.
const machinePackageOverrides: Record<string, string> = {
	'segment-group': 'radio-group',
};

// Injected at the hook layer (components.ts / create-machine.ts), never part of
// a generated component's own configKeys.
const hookInjectedProps = new Set(['dir', 'getRootNode']);

// Investigated, confirmed divergences between extracted configKeys and zag's
// `props` export. Each reason documents why the gap is real, not a parsing bug —
// read the upstream root file before adding an entry here.
const gateExceptions: Record<string, string> = {
	tour: 'Root receives a useTour instance instead of building its own machine; config props live at the useTour call site (see part override)',
};

// P0 regression class (four components silently lost all machine config props to
// a regex bug) must never ship silently again: compare extracted configKeys
// against zag's own props metadata and fail the build on unexplained gaps.
async function verifyZagProps(dir: string, configKeys: readonly string[]) {
	const packageName = machinePackageOverrides[dir] ?? dir;
	let mod: Record<string, unknown>;
	try {
		mod = await import(`@zag-js/${packageName}`);
	} catch {
		console.warn(`[zag-props-gate] no @zag-js/${packageName} package for ${dir}; skipping`);
		return;
	}
	const zagProps = mod.props;
	if (!Array.isArray(zagProps)) {
		console.warn(
			`[zag-props-gate] @zag-js/${packageName} does not export \`props\`; skipping ${dir}`
		);
		return;
	}
	const configured = new Set(configKeys);
	const missing = (zagProps as string[]).filter(
		(key) => !hookInjectedProps.has(key) && !configured.has(key)
	);
	if (missing.length === 0) return;
	const reason = gateExceptions[dir];
	if (reason) {
		console.warn(`[zag-props-gate] ${dir}: accepted divergence (${reason}): ${missing.join(', ')}`);
		return;
	}
	throw new Error(
		`[zag-props-gate] ${dir}: configKeys missing zag props [${missing.join(', ')}] from @zag-js/${packageName} — extraction bug or undocumented gateException`
	);
}

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
	// Checkbox.Group is a plain Solid value-aggregation hook (no zag machine) —
	// ported by hand rather than extracted, since there's no root/getter source to
	// parse it from. Solid's createSignal/createMemo map onto Ripple's
	// track(initial) / track(() => ...) directly. Upstream also falls back to
	// useFieldsetContext for disabled/invalid; Field↔control integration is out of
	// scope this round (00-shared-context.md), so that fallback is intentionally
	// not ported — group-level disabled/invalid come only from Group's own props.
	checkbox: `export type UseCheckboxGroupProps = {
	value?: string[];
	defaultValue?: string[];
	onValueChange?: (value: string[]) => void;
	disabled?: boolean;
	readOnly?: boolean;
	invalid?: boolean;
	name?: string;
	maxSelectedValues?: number;
};

export type CheckboxGroupApi = {
	isChecked(value: string | undefined): boolean;
	value: string[];
	name: string | undefined;
	disabled: boolean | undefined;
	readOnly: boolean | undefined;
	invalid: boolean | undefined;
	setValue(value: string[]): void;
	addValue(value: string): void;
	toggleValue(value: string): void;
	getItemProps(itemProps: { value: string | undefined }): AnyRecord;
};

export function useCheckboxGroup(props: UseCheckboxGroupProps = {}): Tracked<CheckboxGroupApi> {
	const uncontrolledValue = track<string[]>(props.defaultValue ?? []);
	const setValue = (next: string[]) => {
		if (props.value === undefined) uncontrolledValue.value = next;
		props.onValueChange?.(next);
	};
	return track(() => {
		const value = props.value ?? uncontrolledValue.value;
		const disabled = props.disabled;
		const readOnly = props.readOnly;
		const invalid = props.invalid;
		const name = props.name;
		const isAtMax = props.maxSelectedValues != null && value.length >= props.maxSelectedValues;
		const isChecked = (val: string | undefined) => value.some((v) => String(v) === String(val));
		const addValue = (val: string) => {
			if (disabled || readOnly) return;
			if (isChecked(val)) return;
			if (isAtMax) return;
			setValue(value.concat(val));
		};
		const removeValue = (val: string) => {
			if (disabled || readOnly) return;
			setValue(value.filter((v) => String(v) !== String(val)));
		};
		const toggleValue = (val: string) => {
			if (isChecked(val)) removeValue(val);
			else addValue(val);
		};
		return {
			isChecked,
			value,
			name,
			disabled,
			readOnly,
			invalid,
			setValue,
			addValue,
			toggleValue,
			getItemProps(itemProps: { value: string | undefined }) {
				const checked = itemProps.value != null ? isChecked(itemProps.value) : undefined;
				return {
					checked,
					onCheckedChange() {
						if (itemProps.value != null) toggleValue(itemProps.value);
					},
					name,
					disabled: disabled || (isAtMax && !checked),
					readOnly,
					invalid,
				};
			},
		};
	});
}`,
};

const specialPrelude: Record<string, string> = {
	drawer: `const drawerStackStore = /*#__PURE__*/ new RippleContext<DrawerStack | null>(null);
const drawerStackApi = /*#__PURE__*/ new RippleContext<Tracked<AnyRecord> | null>(null);`,
	// Carries the enclosing menu's getTriggerItemProps(childApi) result down to a
	// nested MenuTriggerItem — see rootOverrides.menu / partOverrides.menu.TriggerItem.
	menu: `const menuTriggerItemProps = /*#__PURE__*/ new RippleContext<Tracked<AnyRecord> | null>(null);`,
	// checkboxGroupAnatomyAttrs mirrors upstream checkbox.anatomy.ts
	// (anatomy.extendWith('group')) — computed once, it's a static data-scope/
	// data-part pair, not per-instance state.
	checkbox: `const checkboxGroupContext = /*#__PURE__*/ new RippleContext<Tracked<CheckboxGroupApi> | null>(null);
const checkboxGroupAnatomyAttrs = /*#__PURE__*/ anatomy.extendWith('group').build().group.attrs;`,
	// carousel-progress-text.tsx applies this directly instead of a zag getter
	// (§4.6) — same static-attrs pattern as checkboxGroupAnatomyAttrs above.
	carousel: `const carouselProgressTextAttrs = /*#__PURE__*/ anatomy.build().progressText.attrs;`,
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
	// FloatingPanel.Trigger's presence override builds its merged props by hand
	// (see presencePartDeclaration) instead of through usePartProps.
	'floating-panel': `import { mergeProps } from '@zag-js/core';`,
	// TriggerItem's override builds its merged props by hand (no api getter exists
	// for it — see partOverrides.menu.TriggerItem).
	menu: `import { mergeProps } from '@zag-js/core';`,
	checkbox: `import { anatomy } from '@zag-js/checkbox';`,
	// ItemPreviewImage's override builds its merged props by hand (needs the
	// object-URL effect before it can call the getter — see partOverrides).
	'file-upload': `import { mergeProps } from '@zag-js/core';`,
	carousel: `import { anatomy } from '@zag-js/carousel';`,
	// ColorPicker.ValueText's `format` prop type (§4.6) — the color-picker package
	// re-exports the Color class but not this format-string union, so it comes
	// straight from color-utils, same as color-picker's own upstream source does.
	'color-picker': `import type { ColorStringFormat } from '@zag-js/color-utils';`,
};

function pascalCase(value: string) {
	return value
		.split('-')
		.map((part) => part[0].toUpperCase() + part.slice(1))
		.join('');
}

function splitKeys(source: string) {
	// `[^>]+` stops at the first `>`, which breaks on nested generics like
	// `createSplitProps<UseSelectProps<T>>()`; `[^(]+` consumes up to the call
	// parens instead, swallowing the generic's own `>`s along the way.
	const match = source.match(/createSplitProps<[^(]+>\(\)\([^,]+,\s*\[([\s\S]*?)\]\)/);
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

// Base UI function-form composition (.agents/backlog.md "Part composition"): every
// generated element gets this branch. `propsExpr` must be the exact Tracked<object>
// the static branch spreads onto the element, so createRenderContent's live-props
// proxy stays backed by the same source the DOM would have received — render swaps
// the element wholesale, so `children` never reaches it (Base UI semantics, not this
// adapter's choice). Nests inside whatever gate already wraps staticBranch (presence
// `@if`, file-upload's `@if (url.value)`) by construction — callers wrap the *result*.
function withRender(propsExpr: string, staticBranch: string) {
	return `@if (props.render) {
		const Content = createRenderContent(${propsExpr}, props.render);
		<{Content} />
	} @else {
		${staticBranch}
	}`;
}

// Root/RootProvider variant: rootless Ark roots (fragment body, no tag) get no
// render prop at all — there is no element for a consumer to replace, and Base UI
// itself has no notion of a render prop on a layout-only fragment root.
function renderableElement(tag: string | undefined, propsExpr: string) {
	if (!tag) return staticElement(tag);
	return withRender(propsExpr, staticElement(tag));
}

type PartSpec = {
	exportName: string;
	partName: string;
	tag: string;
	getter?: string;
	keys: string[];
	provide?: string;
	inherit?: string[];
};

// Presence layer (see binding-runtime.tsrx useRootPresence/PresenceState/usePartProps):
// Ark roots that split presence props from their own config and hand descendant
// parts a presence machine. Detected the same way as everything else here — by
// what the upstream source itself does — rather than a hardcoded directory list.
function isPresenceRoot(rootSource: string) {
	return rootSource.includes('splitPresenceProps');
}

type PresenceBehavior =
	| { gate?: boolean; mergePresence?: boolean; presenceRef?: boolean }
	| { ariaControls: 'null' | 'floating-panel' };

const PRESENCE_CONTENT: PresenceBehavior = { gate: true, mergePresence: true, presenceRef: true };
const PRESENCE_GATE: PresenceBehavior = { gate: true };

// Per-part presence behavior, read off the 28 upstream files that call
// usePresenceContext() (.scratch/fix-specs/02-generator.md §3). A generator-time
// assertion checks this table's keys against that file set on every run, so
// upstream drift (a part gaining/losing presence) breaks the build loudly
// instead of silently generating stale bindings.
const presencePartBehaviors: Record<string, Record<string, PresenceBehavior>> = {
	'color-picker': { Content: PRESENCE_CONTENT, Positioner: PRESENCE_GATE },
	combobox: { Content: PRESENCE_CONTENT, Positioner: PRESENCE_GATE },
	'date-picker': { Content: PRESENCE_CONTENT, Positioner: PRESENCE_GATE },
	dialog: {
		Content: PRESENCE_CONTENT,
		Positioner: PRESENCE_GATE,
		Trigger: { ariaControls: 'null' },
	},
	drawer: {
		Content: PRESENCE_CONTENT,
		Positioner: PRESENCE_GATE,
		Trigger: { ariaControls: 'null' },
	},
	'floating-panel': {
		Content: PRESENCE_CONTENT,
		Positioner: PRESENCE_GATE,
		Trigger: { ariaControls: 'floating-panel' },
	},
	'hover-card': { Content: PRESENCE_CONTENT, Positioner: PRESENCE_GATE },
	menu: { Content: PRESENCE_CONTENT, Positioner: PRESENCE_GATE, Trigger: { ariaControls: 'null' } },
	popover: {
		Content: PRESENCE_CONTENT,
		Positioner: PRESENCE_GATE,
		Trigger: { ariaControls: 'null' },
	},
	select: { Content: PRESENCE_CONTENT, Positioner: PRESENCE_GATE },
	tooltip: { Content: PRESENCE_CONTENT, Positioner: PRESENCE_GATE },
	tour: { Positioner: PRESENCE_GATE },
};

function presencePartDeclaration(
	componentName: string,
	part: PartSpec,
	behavior: PresenceBehavior
) {
	if ('ariaControls' in behavior) {
		if (behavior.ariaControls === 'floating-panel') {
			// Upstream builds `{...triggerProps, 'aria-controls': undefined}` via a plain
			// object spread, not a mergeProps chain: zag's mergeProps treats a later
			// `undefined` as "keep the earlier value" (see merge-props.mjs), which would
			// silently no-op this clear if routed through usePartProps's chained merge —
			// bespoke body instead, mirroring floating-panel-trigger.tsx exactly.
			return `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children, render: _render, ...localProps } = props;
	const api = context.get();
	if (!api) throw new Error('${componentName}.${part.partName} must be rendered inside ${componentName}.Root or RootProvider');
	const presence = usePresenceState(presenceContext);
	const mergedProps = track(() => {
		const triggerProps = api.value.${part.getter ?? 'getTriggerProps'}();
		return mergeProps(
			{ ...triggerProps, 'aria-controls': presence.value.unmounted ? undefined : triggerProps['aria-controls'] },
			localProps,
		);
	});
	${withRender('mergedProps', `<${part.tag} {...mergedProps.value}>{children}</${part.tag}>`)}
}`;
		}
		// Four triggers share the exact same odd-looking upstream expression
		// (`unmounted && null`, which clears aria-controls in both branches once it
		// survives zag's mergeProps) — mirrored verbatim rather than "fixed".
		const fields = [
			`context`,
			part.getter ? `getter: '${part.getter}'` : undefined,
			part.keys.length ? `propKeys: ${literal(part.keys)}` : undefined,
			`presence: presenceContext`,
			`presenceProps: (state) => ({ 'aria-controls': state.unmounted && null })`,
		].filter(Boolean);
		return `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ ${fields.join(', ')} }, props);
	${withRender('mergedProps', staticElement(part.tag))}
}`;
	}

	const needsRef = Boolean(behavior.presenceRef);
	const needsPresenceLocal = Boolean(behavior.gate) || needsRef;
	const fields = [
		`context`,
		part.getter ? `getter: '${part.getter}'` : undefined,
		part.keys.length ? `propKeys: ${literal(part.keys)}` : undefined,
		behavior.mergePresence ? `presence: presenceContext` : undefined,
		needsRef ? `omitKeys: ['ref']` : undefined,
	].filter(Boolean);
	// Composed once at setup, not inside mergedProps' track(): ripple's
	// apply_element_spread caches ref effects by symbol+function identity
	// (.scratch/ripple-upstream render.js), so recreating either per update would
	// destroy/recreate the DOM ref binding on every reactive props change.
	// `node: any` (not the tag-specific HTMLDivElement/HTMLButtonElement/... ref type
	// every part's own `ref` prop carries): hoisting this callback out of the JSX
	// `ref={...}` attribute position loses the contextual per-tag inference that inline
	// arrow had, and `ref(node)` below must satisfy whatever narrower element type the
	// part's own `ref` prop expects — `any` is the honest common denominator, not a
	// widened lie, since this same value is also handed to setNode(HTMLElement | null).
	// ripple's ref() binder (blocks.js) wraps a callback ref in an effect and invokes it
	// on mount; reading `presence.value` inside it (reactive) means it can re-fire on
	// later updates too — that's fine, setNode is idempotent for the same node — but it
	// only runs a *returned* function as cleanup, it never re-invokes the callback with
	// `null`. Not returning one here matches the pre-existing static-branch behavior
	// this replaces; presence's own unmount detection never depended on that firing.
	// `let`, not `const`: the compiler lowers a bare-identifier `ref={x}` JSX attribute
	// into `_$_.ref(el, () => x, (v) => (x = v))` unconditionally (it can't know
	// statically whether `x` is a callback or a plain mutable ref-var) — the generated
	// reassignment target must stay legal JS even though ref()'s runtime never actually
	// calls that setter for a function value (verified in blocks.js: the setter only
	// fires in ref()'s "plain mutable var" fallback, never for `typeof value ===
	// 'function'`). A `const` here type-checks fine but fails the rolldown pack.
	const refSetup = needsRef
		? `const presenceRefKey = createRefKey();\n\tlet applyPresenceRef = (node: any) => { presence.value.setNode(node); if (typeof ref === 'function') ref(node); };\n\t`
		: '';
	const refAttr = needsRef ? ` ref={applyPresenceRef}` : '';
	const element = `<${part.tag} {...mergedProps.value}${refAttr}>{children}</${part.tag}>`;
	// Ref contract (verified against .scratch/ripple-upstream/packages/ripple/src/runtime/
	// internal/client/render.js + tsrx-ripple/tests/client/ref.test.tsrx "spreading into
	// composite refs"): a plain `ref` key in a spread object gets NO special treatment
	// (create_ref_prop, which tags a callback so apply_element_spread's string-key path
	// recognizes it, isn't exported from 'ripple'). createRefKey() mints a Symbol that
	// IS recognized — apply_element_spread applies whatever function sits under any own
	// symbol whose description is 'ref', tagged or not, and that survives being spread
	// again through a consumer's own rest-props forwarding. So the composed ref rides
	// in as a symbol-keyed entry, invisible to a plain `{...props}` or destructure —
	// the render consumer needs no special handling at all.
	const renderPropsExpr = needsRef
		? `track(() => ({ ...mergedProps.value, [presenceRefKey]: applyPresenceRef }))`
		: 'mergedProps';
	const rendered = withRender(renderPropsExpr, element);
	const body = behavior.gate ? `@if (!presence.value.unmounted) {\n\t\t${rendered}\n\t}` : rendered;
	return `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children${needsRef ? ', ref' : ''} } = props;
	${needsPresenceLocal ? 'const presence = usePresenceState(presenceContext);\n\t' : ''}${refSetup}const mergedProps = usePartProps({ ${fields.join(', ')} }, props);
	${body}
}`;
}

// `content`/`needsApi`/`prelude`/`extraKeys` support the derived-content-fallback
// overrides (§4.6): upstream parts that render machine-derived text when no
// children are given. Keeping this in the same function as the plain path (not
// a parallel one) means the usePartProps field wiring (getter/propKeys/provide/
// inherit) stays identical between the two — only the rendered body differs.
function partDeclaration(
	part: PartSpec,
	options?: {
		extraKeys?: readonly string[];
		needsApi?: boolean;
		prelude?: string;
		content?: (part: PartSpec) => string;
	}
) {
	const effectivePart = options?.extraKeys?.length
		? { ...part, keys: [...new Set([...part.keys, ...options.extraKeys])] }
		: part;
	const inheritedVariables = effectivePart.inherit?.map(
		(name) => `${name[0].toLowerCase() + name.slice(1)}Props`
	);
	const fields = [
		`context`,
		effectivePart.getter ? `getter: '${effectivePart.getter}'` : undefined,
		effectivePart.keys.length ? `propKeys: ${literal(effectivePart.keys)}` : undefined,
		effectivePart.provide
			? `provideProps: ${effectivePart.provide[0].toLowerCase() + effectivePart.provide.slice(1)}Props`
			: undefined,
		inheritedVariables?.length === 1
			? `inheritedProps: ${inheritedVariables[0]}`
			: inheritedVariables?.length
				? `inheritedProps: [${inheritedVariables.join(', ')}]`
				: undefined,
	].filter(Boolean);
	const setup = [options?.needsApi ? 'const api = context.get()!;' : undefined, options?.prelude]
		.filter(Boolean)
		.join('\n\t');
	// A render consumer replaces the element wholesale, so it never sees the
	// derived-content fallback (`children || api.value.xxx`) either — only the plain
	// element does. Both the default path and every derived-content `content`
	// override route through the same withRender wrap here rather than each
	// override adding its own branch.
	const staticBranch = options?.content
		? options.content(effectivePart)
		: staticElement(effectivePart.tag);
	return `export function ${effectivePart.partName}(props: ${effectivePart.partName}Props) @{
	let &{ children } = props;
	${setup ? setup + '\n\t' : ''}const mergedProps = usePartProps({ ${fields.join(', ')} }, props);
	${withRender('mergedProps', staticBranch)}
}`;
}

// Full-body replacements for parts the uniform template cannot express (bespoke
// imperative upstream semantics — nested machines, effects, non-Root anatomy).
// A function form is for overrides that still need per-part data (e.g. drawer's
// two indent parts share one shape but differ in which getter they call).
const partOverrides: Record<string, Record<string, string | ((part: PartSpec) => string)>> = {
	'signature-pad': {
		// render replaces the whole svg — including the machine-drawn <path> strokes,
		// same "children ignored" rule as everywhere else; a render consumer that
		// wants the strokes composes them itself off the SignaturePad api/context.
		Segment: `export function Segment(props: SegmentProps) @{
	let &{ children } = props;
	const api = context.get();
	if (!api) throw new Error('SignaturePad.Segment must be rendered inside SignaturePad.Root');
	const mergedProps = usePartProps({ context, getter: 'getSegmentProps' }, props);
	${withRender(
		'mergedProps',
		`<svg {...mergedProps.value}>
		<title>Signature</title>
		@for (const path of api.value.paths) {
			<path {...api.value.getSegmentPathProps({ path })} />
		}
		@if (api.value.currentPath) {
			<path {...api.value.getSegmentPathProps({ path: api.value.currentPath })} />
		}
		{children}
	</svg>`
	)}
}`,
	},
	drawer: {
		// Indentation reads from the shared stack API (drawerStackApi), not this
		// instance's DrawerApi — every open drawer in the stack indents together.
		Indent: (part) => drawerIndentDeclaration(part, 'getIndentProps'),
		IndentBackground: (part) => drawerIndentDeclaration(part, 'getIndentBackgroundProps'),
	},
	menu: {
		// Upstream menu-item.tsx registers onSelect via addItemListener in an
		// effect (GitHub issue #3: getItemProps ignores onSelect, so routing it
		// through propKeys alone silently drops the callback). `itemProps` reuses
		// the same reactive props usePartProps already provides to menuItemProps
		// instead of re-deriving the split — one source of truth for the item's
		// {value, disabled, closeOnSelect, valueText, onSelect} bag.
		Item: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children } = props;
	const api = context.get();
	if (!api) throw new Error('Menu.${part.partName} must be rendered inside Menu.Root or RootProvider');
	const mergedProps = usePartProps(
		{ context, getter: '${part.getter}', propKeys: ${literal(part.keys)}, provideProps: menuItemProps },
		props,
	);
	const itemProps = menuItemProps.get()!;
	effect(() => {
		const onSelect = itemProps.value.onSelect;
		if (!onSelect) return;
		return api.value.addItemListener({ id: api.value.getItemState(itemProps.value as any).id, onSelect });
	});
	${withRender('mergedProps', `<${part.tag} {...mergedProps.value}>{children}</${part.tag}>`)}
}`,
		// Renders inside a parent Menu.Item, standing in for it while it opens a
		// submenu. Reads the parent-provided trigger-item props (wired by the Root
		// override below) instead of an api getter — there is none for this; upstream
		// reads it off Solid context (useMenuTriggerItemContext) the same way.
		TriggerItem: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children, render: _render, ...localProps } = props;
	const triggerProps = menuTriggerItemProps.get();
	const mergedProps = track(() => mergeProps(triggerProps?.value ?? {}, localProps));
	menuItemProps.set(track(() => ({ value: mergedProps.value['data-value'] })));
	${withRender('mergedProps', `<${part.tag} {...mergedProps.value}>{children}</${part.tag}>`)}
}`,
	},
	checkbox: {
		// The OUTER wrapper for a set of Checkbox.Root instances, not a part inside
		// one — must not call usePartProps/useBindingContext (there is no Root api
		// to bind to yet; Root instead reads *this* context, see rootOverrides.checkbox).
		// Spread order is localProps-then-attrs (attrs win) to match upstream
		// checkbox-group.tsx exactly — the opposite of carousel's progressText
		// (attrs-then-props, user wins); upstream itself isn't consistent between
		// the two, so this mirrors each source file rather than picking one rule.
		Group: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children } = props;
	const group = useCheckboxGroup(props);
	checkboxGroupContext.set(group);
	const localProps = track(() => splitProps(props, ${literal(part.keys)})[1]);
	${withRender(
		`track(() => ({ role: 'group', ...localProps.value, ...checkboxGroupAnatomyAttrs }))`,
		`<${part.tag} role="group" {...localProps.value} {...checkboxGroupAnatomyAttrs}>{children}</${part.tag}>`
	)}
}`,
		GroupProvider: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children, value } = props;
	checkboxGroupContext.set(value);
	const localProps = track(() => splitProps(props, ${literal(part.keys)})[1]);
	${withRender(
		`track(() => ({ role: 'group', ...localProps.value, ...checkboxGroupAnatomyAttrs }))`,
		`<${part.tag} role="group" {...localProps.value} {...checkboxGroupAnatomyAttrs}>{children}</${part.tag}>`
	)}
}`,
	},
	'file-upload': {
		// Upstream creates the preview's object URL itself (createFileUrl) instead
		// of taking one as a prop; the generic getter-only template had no url to
		// pass getItemPreviewImageProps, so it always rendered `src=undefined`.
		ItemPreviewImage: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children, render: _render, ...localProps } = props;
	const api = context.get();
	if (!api) throw new Error('FileUpload.${part.partName} must be rendered inside FileUpload.Root or RootProvider');
	const itemProps = fileUploadItemProps.get();
	if (!itemProps) throw new Error('FileUpload.${part.partName} must be rendered inside FileUpload.Item');
	const url = track('');
	effect(() => {
		return api.value.createFileUrl(itemProps.value.file, (nextUrl) => {
			url.value = nextUrl;
		});
	});
	const mergedProps = track(() =>
		mergeProps(
			api.value.getItemPreviewImageProps({ ...itemProps.value, url: url.value } as any),
			localProps,
		),
	);
	@if (url.value) {
		${withRender('mergedProps', `<${part.tag} {...mergedProps.value} />`)}
	}
}`,
		// Reads the item props context set by the enclosing Item — see
		// file-upload-item-name.tsx / file-upload-item-size-text.tsx.
		ItemName: (part) =>
			partDeclaration(part, {
				prelude: 'const itemProps = fileUploadItemProps.get()!;',
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || itemProps.value.file.name}</${p.tag}>`,
			}),
		ItemSizeText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				prelude: 'const itemProps = fileUploadItemProps.get()!;',
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.getFileSize(itemProps.value.file)}</${p.tag}>`,
			}),
	},
	// Derived-content fallbacks (§4.6): each part renders machine-derived text
	// when the caller gives no children. `needsApi` hoists `context.get()!` once
	// at setup (not inside the JSX expression) matching the established
	// context.get()-at-setup idiom used by every other bespoke override here.
	'angle-slider': {
		ValueText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.valueAsDegree}</${p.tag}>`,
			}),
	},
	clipboard: {
		ValueText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) => `<${p.tag} {...mergedProps.value}>{children || api.value.value}</${p.tag}>`,
			}),
	},
	'color-picker': {
		ValueText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) => `<${p.tag} {...mergedProps.value}>{children || ((props as any).format
					? api.value.value.toString((props as any).format)
					: api.value.valueAsString)}</${p.tag}>`,
			}),
	},
	listbox: {
		ValueText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				extraKeys: ['placeholder'],
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.valueAsString || (props as any).placeholder}</${p.tag}>`,
			}),
	},
	progress: {
		ValueText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.percentAsString}</${p.tag}>`,
			}),
	},
	slider: {
		ValueText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.value.join(',')}</${p.tag}>`,
			}),
		DraggingIndicator: (part) =>
			partDeclaration(part, {
				needsApi: true,
				prelude: 'const thumbProps = sliderThumbProps.get()!;',
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.getThumbValue(thumbProps.value.index)}</${p.tag}>`,
			}),
	},
	// select-value-text.tsx renders no children — mirrored exactly rather than
	// forced through the generic children-destructuring path.
	select: {
		ValueText: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	const api = context.get()!;
	const mergedProps = usePartProps(
		{ context, getter: '${part.getter}', propKeys: ${literal([...part.keys, 'placeholder'])} },
		props,
	);
	${withRender('mergedProps', `<${part.tag} {...mergedProps.value}>{api.value.valueAsString || (props as any).placeholder}</${part.tag}>`)}
}`,
	},
	// timer-item.tsx renders formattedTime[type] only — no children fallback.
	timer: {
		Item: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	const api = context.get()!;
	const mergedProps = usePartProps(
		{ context, getter: '${part.getter}', propKeys: ${literal(part.keys)} },
		props,
	);
	${withRender('mergedProps', `<${part.tag} {...mergedProps.value}>{(api.value.formattedTime as any)[(props as any).type]}</${part.tag}>`)}
}`,
	},
	carousel: {
		// carousel-progress-text.tsx doesn't call a zag getter at all — it computes
		// the label itself and applies static anatomy attrs directly, so this
		// bypasses usePartProps like Checkbox.Group does.
		ProgressText: (part) => `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children, render: _render, ...localProps } = props;
	const api = context.get()!;
	const progressText = track(() => \`\${api.value.page + 1} / \${api.value.pageSnapPoints.length}\`);
	${withRender(
		`track(() => ({ ...carouselProgressTextAttrs, ...localProps }))`,
		`<${part.tag} {...carouselProgressTextAttrs} {...localProps}>{children || progressText.value}</${part.tag}>`
	)}
}`,
	},
	tour: {
		// tour-action-trigger.tsx's fallback is a static field off the split
		// `action` prop, not an api read, so this doesn't need needsApi.
		ActionTrigger: (part) =>
			partDeclaration(part, {
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || (props as any).action?.label}</${p.tag}>`,
			}),
		ProgressText: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.getProgressText()}</${p.tag}>`,
			}),
		Title: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.step?.title}</${p.tag}>`,
			}),
		Description: (part) =>
			partDeclaration(part, {
				needsApi: true,
				content: (p) =>
					`<${p.tag} {...mergedProps.value}>{children || api.value.step?.description}</${p.tag}>`,
			}),
	},
};

// Nested Menu.Root/RootProvider read the enclosing menu off `context` BEFORE
// setting their own instance, then wire parent/child services together and
// publish getTriggerItemProps for a MenuTriggerItem rendered inside a parent
// Menu.Item (menu-root.tsx / menu-root-provider.tsx). Outside a nested menu,
// `parentApi` is null and both Root variants behave exactly like the generic
// template. `.service` is typed away by BindingContext<TApi> (Tracked<TApi>
// only) even though createMachineHook always attaches it — `as any` bridges that
// representational gap rather than widening the context's public type everywhere.
// childApiExpr must be re-evaluated inside the effect/track callbacks (never
// hoisted to a plain variable): the untracked setParent call wants whatever
// api is current at that moment (matches upstream's one-shot onMount, services
// are stable so a snapshot there is fine), but getTriggerItemProps' result
// (aria-expanded/data-state on the trigger item) depends on the CHILD menu's
// live open state, so track() must actually read `.value` inside its callback
// to subscribe — passing a hoisted snapshot would freeze it at mount-time state.
const menuNestingEffect = (childApiExpr: string) => `if (parentApi) {
		effect(() => {
			untrack(() => {
				(parentApi as any).value.setChild(childService);
				${childApiExpr}.setParent((parentApi as any).service);
			});
		});
		menuTriggerItemProps.set(track(() => (parentApi as any).value.getTriggerItemProps(${childApiExpr})));
	}`;

const rootOverrides: Record<string, (configKeys: string[]) => string> = {
	menu: (configKeys) => `export function Root(props: RootProps) @{
	let &{ children } = props;
	const parentApi = context.get();
	useRootProps(
		{
			context,
			configKeys: ${literal(configKeys)},
			omitKeys: PRESENCE_KEYS,
			useMachine: useMenu as any,
		},
		props,
	);
	const api = context.get()!;
	const childService = (api as any).service;
	useRootPresence(presenceContext, () => api.value.open, props);
	${menuNestingEffect('api.value')}
	<>
		{children}
	</>
}`,
	// upstream use-checkbox.ts folds checkboxGroup.getItemProps({value}) under the
	// individual checkbox's own props (mergeProps(groupProps, ownProps) — own wins)
	// at the useCheckbox hook layer; we do it here because hooks (components.ts)
	// can't import a generated file's context. Consequence: a direct useCheckbox()
	// caller (bypassing Checkbox.Root) does not get group integration.
	checkbox: (configKeys) => `export function Root(props: RootProps) @{
	let &{ children } = props;
	const group = checkboxGroupContext.get();
	const groupItemProps = group
		? track(() => group.value.getItemProps({ value: (props as AnyRecord).value }))
		: undefined;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: ${literal(configKeys)},
			machineDefaults: groupItemProps
				? {
						checked: () => groupItemProps.value.checked,
						onCheckedChange: () => groupItemProps.value.onCheckedChange,
						name: () => groupItemProps.value.name,
						disabled: () => groupItemProps.value.disabled,
						readOnly: () => groupItemProps.value.readOnly,
						invalid: () => groupItemProps.value.invalid,
					}
				: undefined,
			useMachine: useCheckbox as any,
		},
		props,
	);
	${withRender('mergedProps', '<label {...mergedProps.value}>{children}</label>')}
}`,
	// Upstream tour-root.tsx does not build a machine at all — Root receives an
	// already-built `tour` (a useTour() instance) as a prop and only provides
	// context + presence. No tour-root-provider.tsx exists upstream either; ours
	// mirrors Root exactly so the namespace still offers both (see
	// rootProviderOverrides.tour and gateExceptions.tour in the zag-props gate).
	tour: () => `export function Root(props: RootProps) @{
	let &{ children } = props;
	context.set(props.tour);
	useRootPresence(presenceContext, () => props.tour.value.open, props);
	<>
		{children}
	</>
}`,
};

const rootProviderOverrides: Record<string, () => string> = {
	menu: () => `export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const parentApi = context.get();
	useRootProviderProps({ context, omitKeys: PRESENCE_KEYS }, props);
	const childService = props.value.service;
	useRootPresence(presenceContext, () => context.get()!.value.open, props);
	${menuNestingEffect('props.value.value')}
	<>
		{children}
	</>
}`,
	tour: () => `export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	context.set(props.tour);
	useRootPresence(presenceContext, () => props.tour.value.open, props);
	<>
		{children}
	</>
}`,
};

// PRESENCE_KEYS is a runtime array (`useRootProps`'s omitKeys), not a type —
// the machine's own Parameters<Hook>[0] never includes these (they're consumed
// by useRootPresence, not the zag machine), so every isPresence root/provider
// must union it in explicitly or the props go untyped-or-rejected. Untagged
// roots (dialog, drawer, menu, popover, tooltip, hover-card: Root renders a
// Fragment, so RootProps falls back to bare ComponentProps with no index
// signature) would otherwise hard type-error on `<Dialog.Root lazyMount>`;
// tagged roots (select, combobox, ...) merely "slip through" via
// ArkPartProps's OpenAttributes index signature today, but that types the
// presence props as `any` instead of `boolean | undefined` — applying this
// uniformly to every isPresence root fixes the untagged case and sharpens the
// tagged one for free.
const presencePropsType = `{
	present?: boolean;
	lazyMount?: boolean;
	unmountOnExit?: boolean;
	onExitComplete?: () => void;
	immediate?: boolean;
	skipAnimationOnMount?: boolean;
}`;

// tour's Root/RootProvider don't build a machine — `tour` is a useTour()
// instance the caller already built (see rootOverrides.tour) — so the generic
// `NonNullable<Parameters<Hook>[0]>`/`{ value: ReturnType<Hook> }` prop shapes
// don't apply; RootProps and RootProviderProps are identical for tour.
const rootPropsTypeOverrides: Record<string, string> = {
	tour: `{ tour: ReturnType<typeof useTour> } & ${presencePropsType} & ComponentProps`,
};

function drawerIndentDeclaration(part: PartSpec, getter: string) {
	return `export function ${part.partName}(props: ${part.partName}Props) @{
	let &{ children } = props;
	const mergedProps = useExternalPartProps({ context: drawerStackApi, getter: '${getter}' }, props);
	${withRender('mergedProps', '<div {...mergedProps.value}>{children}</div>')}
}`;
}

// Public prop-type replacements paired with partOverrides above: drawer's indent
// parts don't own a DrawerApi getter, so the generic PartProps<tag, Api[getter]>
// shape would name a getter DrawerApi doesn't have.
const typeOverrides: Record<string, Record<string, string>> = {
	drawer: {
		Indent: `ArkPartProps<'div'>`,
		IndentBackground: `ArkPartProps<'div'>`,
	},
	checkbox: {
		Group: `ArkPartProps<'div'> & UseCheckboxGroupProps`,
		GroupProvider: `ArkPartProps<'div'> & { value: Tracked<CheckboxGroupApi> }`,
	},
	// `placeholder`/`format` are Ark-level UI props, not part of the zag getter's
	// own parameter type, so publicPartType's GetterProps<...> extraction can't
	// see them (the getters take no arguments at all) — named explicitly instead.
	select: {
		ValueText: `PartProps<'span', Api['getValueTextProps']> & { placeholder?: string }`,
	},
	listbox: {
		ValueText: `PartProps<'span', Api['getValueTextProps']> & { placeholder?: string }`,
	},
	'color-picker': {
		ValueText: `PartProps<'span', Api['getValueTextProps']> & { format?: ColorStringFormat }`,
	},
};

function publicPartType(part: PartSpec) {
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
	await verifyZagProps(directory.name, configKeys);
	const isPresence = isPresenceRoot(rootSource);
	const presenceParts = new Set<string>();
	const parts: PartSpec[] = [];
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
		if (source.includes('usePresenceContext(')) presenceParts.add(namespaceName);
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

	// Upstream drift guard: if a part starts (or stops) calling usePresenceContext,
	// presencePartBehaviors goes stale silently unless this throws.
	const expectedPresenceParts = new Set(Object.keys(presencePartBehaviors[directory.name] ?? {}));
	const presencePartsMismatch =
		presenceParts.size !== expectedPresenceParts.size ||
		[...presenceParts].some((name) => !expectedPresenceParts.has(name));
	if (presencePartsMismatch) {
		const missingFromTable = [...presenceParts].filter((name) => !expectedPresenceParts.has(name));
		const missingFromSource = [...expectedPresenceParts].filter((name) => !presenceParts.has(name));
		throw new Error(
			`[presence-gate] ${directory.name}: usePresenceContext part set drifted from presencePartBehaviors ` +
				`(missing from table: [${missingFromTable.join(', ')}], stale in table: [${missingFromSource.join(', ')}])`
		);
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
			const presenceBehavior = presencePartBehaviors[directory.name]?.[part.partName];
			if (presenceBehavior) return presencePartDeclaration(componentName, part, presenceBehavior);
			const override = partOverrides[directory.name]?.[part.partName];
			if (override) return typeof override === 'function' ? override(part) : override;
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
	const rootDeclaration =
		rootOverrides[directory.name]?.(configKeys) ??
		`export function Root(props: RootProps) @{
	let &{ children } = props;
	${rootTag ? 'const mergedProps = ' : '// Rootless upstream: the call runs for its machine/context side effects only.\n\t'}useRootProps({
		context,
		configKeys: ${literal(configKeys)},
	${directory.name === 'drawer' ? 'defaultMachineProps: () => ({ stack: drawerStackStore.get() ?? undefined }),\n\t' : ''}${isPresence ? 'omitKeys: PRESENCE_KEYS,\n\t' : ''}
		useMachine: ${hook} as any,
	}, props);
	${isPresence ? 'useRootPresence(presenceContext, () => context.get()!.value.open, props);\n\t' : ''}${renderableElement(rootTag, 'mergedProps')}
}`;
	const rootProviderDeclaration =
		rootProviderOverrides[directory.name]?.() ??
		`export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	${rootTag ? 'const mergedProps = ' : ''}useRootProviderProps({ context${isPresence ? ', omitKeys: PRESENCE_KEYS' : ''} }, props);
	${isPresence ? 'useRootPresence(presenceContext, () => context.get()!.value.open, props);\n\t' : ''}${renderableElement(rootTag, 'mergedProps')}
}`;
	// Root overrides (tour) can replace the generic body wholesale and drop the
	// generic hook calls entirely — derive their imports from what the emitted
	// text actually calls instead of assuming every presence-tagged directory
	// still uses useRootProps/useRootProviderProps/PRESENCE_KEYS.
	const rootBodyText = rootDeclaration + rootProviderDeclaration;
	// Scanned separately from rootBodyText (kept as-is above) so the render-prop
	// import checks below also see part bodies, not just Root/RootProvider.
	const allBodyText = rootBodyText + partDeclarations;
	// A tagged Root/RootProvider always gets a render prop (rootless fragment roots
	// — menu, tour — have no element for a consumer to replace); every directory
	// generated here has at least one part (verified: no directory in
	// manifest.json has zero non-Root/RootProvider/Context parts), so `RenderProp`
	// itself is always referenced by at least a part type below.
	const rootRenderType = rootTag ? ` & { render?: RenderProp<'${rootTag}'> }` : '';
	const rootPropsType =
		rootPropsTypeOverrides[directory.name] ??
		`${rootTag ? `ArkPartProps<'${rootTag}'>` : 'ComponentProps'} & NonNullable<Parameters<Hook>[0]>${isPresence ? ` & ${presencePropsType}` : ''}${rootRenderType}`;
	const rootProviderPropsType =
		rootPropsTypeOverrides[directory.name] ??
		`${rootTag ? `ArkPartProps<'${rootTag}'>` : 'ComponentProps'} & { value: ReturnType<Hook> }${isPresence ? ` & ${presencePropsType}` : ''}${rootRenderType}`;
	const partTypesText = parts
		.map((part) => {
			const typeOverride = typeOverrides[directory.name]?.[part.partName];
			// Parenthesized so it composes with typeOverrides (drawer's Indent, etc.)
			// for free instead of each override needing its own render entry.
			return `export type ${part.partName}Props = (${typeOverride ?? publicPartType(part)}) & { render?: RenderProp<'${part.tag}'> };`;
		})
		.join('\n');
	const bindingRuntimeImports = [
		'createApiContext',
		'createItemContext',
		'useExternalPartProps',
		'usePartProps',
		...(rootBodyText.includes('useRootProps(') ? ['useRootProps'] : []),
		...(rootBodyText.includes('useRootProviderProps(') ? ['useRootProviderProps'] : []),
		...(rootBodyText.includes('useRootPresence(') ? ['useRootPresence'] : []),
		...(isPresence ? ['usePresenceState'] : []),
		...(rootBodyText.includes('PRESENCE_KEYS') ? ['PRESENCE_KEYS'] : []),
		// Checkbox.Group renders its own element outside usePartProps (see
		// partOverrides.checkbox) but still needs the same children/key split.
		...(directory.name === 'checkbox' ? ['splitProps'] : []),
		...(allBodyText.includes('createRenderContent(') ? ['createRenderContent'] : []),
		'type ArkPartProps',
		'type ComponentProps',
		'type GetterProps',
		'type PartProps',
		'type RenderProp',
		...(isPresence ? ['type PresenceState'] : []),
	].join(', ');
	// Nested-menu wiring needs untrack (see menuNestingEffect) — no other override
	// needs a ripple runtime import beyond the baseline, so this stays a one-off
	// rather than a generalized per-directory list.
	const rippleImports = [
		'Context as RippleContext',
		'effect',
		'track',
		...(directory.name === 'menu' ? ['untrack'] : []),
		// Only presence-ref parts (Content — see presencePartBehaviors) mint a
		// spreadable ref via createRefKey; every other render-prop element relies
		// on the plain merged-props object with no ref entry at all.
		...(allBodyText.includes('createRefKey(') ? ['createRefKey'] : []),
		'type Children',
		'type Tracked',
	].join(', ');
	const source = `import { ${rippleImports} } from 'ripple';
${extraImports[directory.name] ?? ''}
import { ${hook} } from '../components';
import { ${bindingRuntimeImports} } from '../binding-runtime.tsrx';

type Hook = typeof ${hook};
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);
${isPresence ? 'const presenceContext = /*#__PURE__*/ new RippleContext<Tracked<PresenceState> | null>(null);' : ''}
${specialPrelude[directory.name] ?? ''}
${contextDeclarations}

${rootDeclaration}
${rootProviderDeclaration}
${partDeclarations}
${itemContextDeclarations}
${specialDeclarations[directory.name] ?? ''}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ${rootPropsType};
export type RootProviderProps = ${rootProviderPropsType};
${partTypesText}

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

// Derived-content fallbacks (§4.6) intentionally not ported: date-picker's
// ValueText render-prop API (For/Show over multi-date selection, separate
// per-value render callback) and color-picker's ChannelSliderValueText (needs
// both channel-props and locale context) are substantially more involved than
// the `children || derivedText` shape every other part in this batch has.
console.warn(
	'[derived-content] known gaps, not ported: date-picker ValueText (render-prop multi-date API), ' +
		'color-picker ChannelSliderValueText (channel + locale context) — both still render {children} only'
);
