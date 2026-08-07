import { createTreeCollection, useTreeView } from '../index';
import { track } from 'ripple';
import { trackSplit } from '../internal/track-split';
import { LuFile, LuFolder, LuChevronRight } from '../internal/lucide-icons.tsrx';

export function TreeView() @{
	let api = useTreeView({
		id: 'tree-view',
		collection,
	});

	<>
		<div {...api.value.getRootProps()}>
			<h3 {...api.value.getLabelProps()}>My Documents</h3>
			<div data-scope="tree-view" data-part="controls">
				<button data-scope="tree-view" data-part="trigger" onClick={() => api.value.collapse()}>
					Collapse All
				</button>
				<button data-scope="tree-view" data-part="trigger" onClick={() => api.value.expand()}>
					Expand All
				</button>
			</div>
			<div {...api.value.getTreeProps()}>
				@if (collection.rootNode.children) {
					@for (const node of collection.rootNode.children; index nodeIndex) {
						<TreeNode node={node} indexPath={[nodeIndex]} api={api.value} />
					}
				}
			</div>
		</div>
	</>
}

type Node = {
	id: string;
	name: string;
	children?: Node[];
};

type TreeViewApi = ReturnType<typeof useTreeView>['value'];

const collection = createTreeCollection<Node>({
	nodeToValue: (node) => node.id,
	nodeToString: (node) => node.name,
	rootNode: {
		id: 'ROOT',
		name: '',
		children: [
			{
				id: 'node_modules',
				name: 'node_modules',
				children: [
					{ id: 'node_modules/zag-js', name: 'zag-js' },
					{ id: 'node_modules/@celados/ripple-ark', name: '@celados/ripple-ark' },
					{ id: 'node_modules/ripple', name: 'ripple' },
					{
						id: 'src/lib/lucide-icons.tsrx',
						name: 'lucide-icons.tsrx',
						children: [
							{ id: 'src/lib/lucide-icons.tsrx#icon', name: 'Icon' },
							{ id: 'src/lib/lucide-icons.tsrx#exports', name: 'exports' },
						],
					},
				],
			},
			{
				id: 'src',
				name: 'src',
				children: [
					{ id: 'src/App.tsrx', name: 'App.tsrx' },
					{ id: 'src/Layout.tsrx', name: 'Layout.tsrx' },
					{
						id: 'src/components',
						name: 'components',
						children: [
							{ id: 'src/components/Button.tsrx', name: 'Button.tsrx' },
							{ id: 'src/components/Card.tsrx', name: 'Card.tsrx' },
						],
					},
					{ id: 'src/index.ts', name: 'index.ts' },
				],
			},
			{ id: 'vite.config.js', name: 'vite.config.js' },
			{ id: 'package.json', name: 'package.json' },
			{ id: 'tsconfig.json', name: 'tsconfig.json' },
			{ id: 'README.md', name: 'README.md' },
		],
	},
});

function TreeNode(props: { indexPath: number[]; node: Node; api: TreeViewApi }) @{
	let [indexPath, node, api] = trackSplit(props, ['indexPath', 'node', 'api']);
	let nodeProps = track(() => ({ indexPath: indexPath.value, node: node.value }));
	let treeApi = track(() => api.value);
	let nodeState = track(() => treeApi.value.getNodeState(nodeProps.value));

	<>
		@if (nodeState.value.isBranch) {
			<div {...treeApi.value.getBranchProps(nodeProps.value)}>
				<div {...treeApi.value.getBranchControlProps(nodeProps.value)}>
					<LuFolder size={16} />
					<span {...treeApi.value.getBranchTextProps(nodeProps.value)}>{node.value.name}</span>
					<span {...treeApi.value.getBranchIndicatorProps(nodeProps.value)}>
						<LuChevronRight size={16} />
					</span>
				</div>
				<div {...treeApi.value.getBranchContentProps(nodeProps.value)}>
					<div {...treeApi.value.getBranchIndentGuideProps(nodeProps.value)} />
					@if (node.value.children) {
						@for (const childNode of node.value.children; index childIndex) {
							let newIndexPath = [...indexPath.value, childIndex];
							<TreeNode node={childNode} indexPath={newIndexPath} api={treeApi.value} />
						}
					}
				</div>
			</div>
		} @else {
			<div {...treeApi.value.getItemProps(nodeProps.value)}>
				<LuFile size={16} />
				{node.value.name}
			</div>
		}
	</>
}
