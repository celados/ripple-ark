import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTreeView } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	createRenderContent,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
	type RenderProp,
} from '../binding-runtime.tsrx';

type Hook = typeof useTreeView;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

const treeViewNodeProps = /*#__PURE__*/ new RippleContext<
	Tracked<Record<string, any>> | null
>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'canRename',
				'checkedValue',
				'collection',
				'defaultCheckedValue',
				'defaultExpandedValue',
				'defaultFocusedValue',
				'defaultSelectedValue',
				'expandedValue',
				'expandOnClick',
				'focusedValue',
				'id',
				'ids',
				'loadChildren',
				'onBeforeRename',
				'onCheckedChange',
				'onExpandedChange',
				'onFocusChange',
				'onLoadChildrenComplete',
				'onLoadChildrenError',
				'onRenameComplete',
				'onRenameStart',
				'onSelectionChange',
				'selectedValue',
				'selectionMode',
				'translations',
				'typeahead',
				'scrollToIndexFn',
			],

			useMachine: useTreeView as any,
		},
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function BranchText(props: BranchTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getBranchTextProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemIndicatorProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Tree(props: TreeProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getTreeProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Branch(props: BranchProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getBranchProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function NodeCheckbox(props: NodeCheckboxProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getNodeCheckboxProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
}
export function BranchTrigger(props: BranchTriggerProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getBranchTriggerProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function NodeRenameInput(props: NodeRenameInputProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getNodeRenameInputProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<input {...mergedProps.value} />
	}
}
export function BranchContent(props: BranchContentProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getBranchContentProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function BranchControl(props: BranchControlProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getBranchControlProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function BranchIndentGuide(props: BranchIndentGuideProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getBranchIndentGuideProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getLabelProps' }, props);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<h3 {...mergedProps.value}>{children}</h3>
	}
}
export function BranchIndicator(props: BranchIndicatorProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getBranchIndicatorProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<div {...mergedProps.value}>{children}</div>
	}
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps(
		{ context, getter: 'getItemTextProps', inheritedProps: treeViewNodeProps },
		props,
	);
	@if (props.render) {
		const Content = createRenderContent(mergedProps, props.render);
		<{Content} />
	} @else {
		<span {...mergedProps.value}>{children}</span>
	}
}
export const NodeContext = /*#__PURE__*/ createItemContext(context, treeViewNodeProps);
export function NodeProvider(props: ArkPartProps & { indexPath: number[]; node: unknown }) @{
	let &{ indexPath, node, children } = props;
	treeViewNodeProps.set(track(() => ({ indexPath, node })));
	{
		children;
	}
}

export function NodeCheckboxIndicator(props: {
	children?: Children;
	indeterminate?: Children;
	fallback?: Children;
}) @{
	const api = context.get();
	const nodeProps = treeViewNodeProps.get();
	if (
		!api || !nodeProps
	) throw new Error('TreeView.NodeCheckboxIndicator must be rendered inside NodeProvider');
	const state = track(() => api.value.getNodeState(nodeProps.value as any));
	@if (state.value.checked === 'indeterminate' && props.indeterminate) {
		{
			props.indeterminate;
		}
	} @else if (state.value.checked === true && props.children) {
		{
			props.children;
		}
	} @else {
		{
			props.fallback;
		}
	}
}
export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type BranchTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type ItemIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type TreeProps = (PartProps<'div', Api['getTreeProps']>) & { render?: RenderProp<'div'> };
export type ItemProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type BranchProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type NodeCheckboxProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };
export type BranchTriggerProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type NodeRenameInputProps = (ArkPartProps<'input'>) & { render?: RenderProp<'input'> };
export type BranchContentProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type BranchControlProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type BranchIndentGuideProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type LabelProps = (PartProps<'h3', Api['getLabelProps']>) & { render?: RenderProp<'h3'> };
export type BranchIndicatorProps = (ArkPartProps<'div'>) & { render?: RenderProp<'div'> };
export type ItemTextProps = (ArkPartProps<'span'>) & { render?: RenderProp<'span'> };

export const TreeView = {
	Root,
	RootProvider,
	BranchText,
	ItemIndicator,
	Tree,
	Item,
	Branch,
	NodeCheckbox,
	BranchTrigger,
	NodeRenameInput,
	BranchContent,
	BranchControl,
	BranchIndentGuide,
	Label,
	BranchIndicator,
	ItemText,
	NodeContext,
	NodeProvider,
	NodeCheckboxIndicator,
	Context,
};
