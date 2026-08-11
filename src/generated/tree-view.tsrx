import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useTreeView } from '../components';
import {
	Part,
	createApiContext,
	createItemContext,
	useRootProps,
	useRootProviderProps,
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function BranchText(props: BranchTextProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getBranchTextProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function ItemIndicator(props: ItemIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemIndicatorProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function Tree(props: TreeProps) @{
	let &{ children } = props;
	<Part tag="div" options={{ context, getter: 'getTreeProps' }} of={props}>{children}</Part>
}
export function Item(props: ItemProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getItemProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function Branch(props: BranchProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getBranchProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function NodeCheckbox(props: NodeCheckboxProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getNodeCheckboxProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function BranchTrigger(props: BranchTriggerProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getBranchTriggerProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function NodeRenameInput(props: NodeRenameInputProps) @{
	<Part
		tag="input"
		options={{ context, getter: 'getNodeRenameInputProps', inheritedProps: treeViewNodeProps }}
		of={props}
	/>
}
export function BranchContent(props: BranchContentProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getBranchContentProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function BranchControl(props: BranchControlProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getBranchControlProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function BranchIndentGuide(props: BranchIndentGuideProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getBranchIndentGuideProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function Label(props: LabelProps) @{
	let &{ children } = props;
	<Part tag="h3" options={{ context, getter: 'getLabelProps' }} of={props}>{children}</Part>
}
export function BranchIndicator(props: BranchIndicatorProps) @{
	let &{ children } = props;
	<Part
		tag="div"
		options={{ context, getter: 'getBranchIndicatorProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
}
export function ItemText(props: ItemTextProps) @{
	let &{ children } = props;
	<Part
		tag="span"
		options={{ context, getter: 'getItemTextProps', inheritedProps: treeViewNodeProps }}
		of={props}
	>{children}</Part>
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
