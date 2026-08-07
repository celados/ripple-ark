import { getDocument, getWindow } from '@zag-js/dom-query';
import { Context, track, type Children, type Tracked } from 'ripple';

export type RootNode = ShadowRoot | Document | Node;
export type Environment = {
	getRootNode(): RootNode;
	getDocument(): Document;
	getWindow(): Window & typeof globalThis;
};

const context = new Context<Tracked<Environment> | null>(null);

function defaultEnvironment(): Environment {
	return {
		getRootNode: () => document,
		getDocument: () => document,
		getWindow: () => window,
	};
}

export function useEnvironmentContext() {
	return context.get() ?? track(defaultEnvironment());
}

export type EnvironmentProviderProps = {
	children?: Children | Children[];
	value?: RootNode | (() => RootNode);
};

export function EnvironmentProvider(props: EnvironmentProviderProps) @{
	let fallbackNode: HTMLSpanElement | null = null;
	const environment = track((): Environment => {
		const root =
			typeof props.value === 'function'
				? props.value()
				: props.value ?? fallbackNode?.getRootNode() ?? document;
		return {
			getRootNode: () => root,
			getDocument: () => getDocument(root),
			getWindow: () => getWindow(root),
		};
	});
	context.set(environment);
	{
		props.children;
	}
	@if (!props.value) {
		<span
			hidden
			ref={(node) => {
				fallbackNode = node;
			}}
		/>
	}
}
