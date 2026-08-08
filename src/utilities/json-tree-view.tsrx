import {
	getRootNode,
	keyPathToKey,
	nodeToString,
	nodeToValue,
	type JsonNode,
} from '@zag-js/json-tree-utils';
import { Context as RippleContext, track, type Children, type Tracked } from 'ripple';
import { useTreeView } from '../components';
import { createTreeCollection } from './collection';

export type UseJsonTreeViewProps = {
	id: string;
	data: unknown;
	defaultExpandedDepth?: number;
	maxPreviewItems?: number;
	collapseStringsAfterLength?: number;
	quotesOnKeys?: boolean;
	groupArraysAfterLength?: number;
	showNonenumerable?: boolean;
};

type JsonTreeApi = ReturnType<typeof useTreeView>;

function branchValues(root: JsonNode, depth: number) {
	const values: string[] = [];
	const visit = (node: JsonNode, currentDepth: number) => {
		if (node.children?.length && currentDepth <= depth) values.push(nodeToValue(node));
		if (currentDepth < depth) node.children?.forEach((child) => visit(child, currentDepth + 1));
	};
	visit(root, 0);
	return values;
}

export function useJsonTreeView(props: UseJsonTreeViewProps): JsonTreeApi {
	const rootNode = track(() => getRootNode(props.data));
	const collection = track(
		() => createTreeCollection<JsonNode>({ nodeToValue, nodeToString, rootNode: rootNode.value }),
	);
	return useTreeView({
		get id() {
			return props.id;
		},
		get collection() {
			return collection.value;
		},
		typeahead: false,
		get defaultExpandedValue() {
			return props.defaultExpandedDepth == null
				? undefined
				: branchValues(rootNode.value, props.defaultExpandedDepth);
		},
	});
}

const context = /*#__PURE__*/ new RippleContext<Tracked<JsonTreeApi['value']> | null>(null);

export type JsonTreeViewRootProps =
	UseJsonTreeViewProps & {
		children?: Children | Children[];
	};

export function JsonTreeViewRoot(props: JsonTreeViewRootProps) @{
	let &{
		id: _id,
		data: _data,
		defaultExpandedDepth: _defaultExpandedDepth,
		maxPreviewItems: _maxPreviewItems,
		collapseStringsAfterLength: _collapseStringsAfterLength,
		quotesOnKeys: _quotesOnKeys,
		groupArraysAfterLength: _groupArraysAfterLength,
		showNonenumerable: _showNonenumerable,
		children,
		...localProps
	} = props;
	const api = useJsonTreeView(props);
	context.set(api);
	<div {...api.value.getRootProps()} {...localProps} data-scope="json-tree-view">{children}</div>
}

export type JsonTreeViewRootProviderProps = {
	value: JsonTreeApi;
	children?: Children | Children[];
};

export function JsonTreeViewRootProvider(props: JsonTreeViewRootProviderProps) @{
	let &{ value, children } = props;
	const api = track(() => value.value);
	context.set(api);
	<div {...api.value.getRootProps()} data-scope="json-tree-view">{children}</div>
}

type JsonTreeNodeProps = {
	node: JsonNode;
	indexPath: number[];
	api: JsonTreeApi['value'];
};

function JsonTreeNode(props: JsonTreeNodeProps) @{
	const nodeProps = { node: props.node, indexPath: props.indexPath };
	const state = track(() => props.api.getNodeState(nodeProps));
	const key = keyPathToKey(props.node.keyPath, { excludeRoot: true });

	<>
		@if (state.value.isBranch) {
			<div {...props.api.getBranchProps(nodeProps)} data-scope="json-tree-view">
				<button {...props.api.getBranchControlProps(nodeProps)}>
					<span {...props.api.getBranchIndicatorProps(nodeProps)}>▸</span>
					<span {...props.api.getBranchTextProps(nodeProps)}>
						{key || nodeToString(props.node)}
					</span>
				</button>
				<div {...props.api.getBranchContentProps(nodeProps)}>
					@for (const child of props.node.children ?? []; index index) {
						<JsonTreeNode node={child} indexPath={[...props.indexPath, index]} api={props.api} />
					}
				</div>
			</div>
		} @else {
			<div {...props.api.getItemProps(nodeProps)} data-scope="json-tree-view">
				<span {...props.api.getItemTextProps(nodeProps)}>
					{key ? `${key}: ` : ''}
					{nodeToString(props.node)}
				</span>
			</div>
		}
	</>
}

export type JsonTreeViewTreeProps = JSX.IntrinsicElements['div'];

export function JsonTreeViewTree(props: JsonTreeViewTreeProps) @{
	const api = context.get();
	if (!api) throw new Error('JsonTreeView.Tree must be rendered inside JsonTreeView.Root');
	const children = api.value.collection.getNodeChildren(api.value.collection.rootNode);
	<div {...api.value.getTreeProps()} {...props} data-scope="json-tree-view">
		@for (const child of children; index index) {
			<JsonTreeNode node={child} indexPath={[index]} api={api.value} />
		}
	</div>
}

export const JsonTreeView = {
	Root: JsonTreeViewRoot,
	RootProvider: JsonTreeViewRootProvider,
	Tree: JsonTreeViewTree,
};
