export { GridCollection, ListCollection, TreeCollection, filePathToTree } from '@zag-js/collection';
import {
	GridCollection,
	ListCollection,
	TreeCollection,
	type CollectionItem,
	type CollectionOptions,
	type GridCollectionOptions,
	type TreeCollectionOptions,
} from '@zag-js/collection';

export const createGridCollection = <T extends CollectionItem>(options: GridCollectionOptions<T>) =>
	new GridCollection(options);
export const createListCollection = <T extends CollectionItem>(options: CollectionOptions<T>) =>
	new ListCollection(options);
export const createTreeCollection = <T>(options: TreeCollectionOptions<T>) =>
	new TreeCollection(options);
