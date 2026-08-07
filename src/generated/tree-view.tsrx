import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTreeView } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useTreeView;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

const treeViewNodeProps = new RippleContext<Record<string, any> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [],

	useMachine: useTreeView as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const BranchText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getBranchTextProps',
	inheritedProps: treeViewNodeProps,
});
export const ItemIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemIndicatorProps',
	inheritedProps: treeViewNodeProps,
});
export const Tree = createPart({ context, defaultTag: 'div', getter: 'getTreeProps' });
export const Item = createPart({
	context,
	defaultTag: 'div',
	getter: 'getItemProps',
	inheritedProps: treeViewNodeProps,
});
export const Branch = createPart({
	context,
	defaultTag: 'div',
	getter: 'getBranchProps',
	inheritedProps: treeViewNodeProps,
});
export const NodeCheckbox = createPart({
	context,
	defaultTag: 'span',
	getter: 'getNodeCheckboxProps',
	inheritedProps: treeViewNodeProps,
});
export const BranchTrigger = createPart({
	context,
	defaultTag: 'div',
	getter: 'getBranchTriggerProps',
	inheritedProps: treeViewNodeProps,
});
export const NodeRenameInput = createPart({
	context,
	defaultTag: 'input',
	getter: 'getNodeRenameInputProps',
	inheritedProps: treeViewNodeProps,
});
export const BranchContent = createPart({
	context,
	defaultTag: 'div',
	getter: 'getBranchContentProps',
	inheritedProps: treeViewNodeProps,
});
export const BranchControl = createPart({
	context,
	defaultTag: 'div',
	getter: 'getBranchControlProps',
	inheritedProps: treeViewNodeProps,
});
export const BranchIndentGuide = createPart({
	context,
	defaultTag: 'div',
	getter: 'getBranchIndentGuideProps',
	inheritedProps: treeViewNodeProps,
});
export const Label = createPart({ context, defaultTag: 'h3', getter: 'getLabelProps' });
export const BranchIndicator = createPart({
	context,
	defaultTag: 'div',
	getter: 'getBranchIndicatorProps',
	inheritedProps: treeViewNodeProps,
});
export const ItemText = createPart({
	context,
	defaultTag: 'span',
	getter: 'getItemTextProps',
	inheritedProps: treeViewNodeProps,
});
export const NodeContext = createItemContext(context, treeViewNodeProps);
export function NodeProvider(props: ArkPartProps & { indexPath: number[]; node: unknown }) @{
	const { indexPath, node, children } = props;
	treeViewNodeProps.set({ indexPath, node });
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
	const state = track(() => api.value.getNodeState(nodeProps as any));
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
export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type BranchTextProps = ArkPartProps;
export type ItemIndicatorProps = ArkPartProps;
export type TreeProps = ArkPartProps;
export type ItemProps = ArkPartProps;
export type BranchProps = ArkPartProps;
export type NodeCheckboxProps = ArkPartProps;
export type BranchTriggerProps = ArkPartProps;
export type NodeRenameInputProps = ArkPartProps;
export type BranchContentProps = ArkPartProps;
export type BranchControlProps = ArkPartProps;
export type BranchIndentGuideProps = ArkPartProps;
export type LabelProps = ArkPartProps;
export type BranchIndicatorProps = ArkPartProps;
export type ItemTextProps = ArkPartProps;

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
