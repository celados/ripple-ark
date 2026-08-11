import { type Children, type DynamicElementType } from 'ripple';

type ElementType = keyof JSX.IntrinsicElements;
export type HTMLProps<T extends ElementType> = JSX.IntrinsicElements[T];

// No-compat cut: this factory used to carry Ark/Radix-style `asChild` polymorphism
// (child cloning + a PolymorphicProps merge). Composition now lives on generated parts
// as Base UI's function-form `render` prop (README "Composition"; binding-runtime's
// RenderProp/createRenderContent) — a dynamic-tag wrapper has no analogous need, so
// `ark.div` etc. is just a plain component around a runtime-chosen tag.
type ArkComponent<T extends ElementType> = (props: HTMLProps<T>) => Children;
type ArkElements = { [T in ElementType]: ArkComponent<T> };

function createArkElement<T extends ElementType>(tag: T): ArkComponent<T> {
	return function ArkElement(props: HTMLProps<T>) @{
		const dynamicTag: DynamicElementType = tag;
		<{dynamicTag} {...props} />
	};
}

function createArkFactory() {
	const cache = new Map<ElementType, ArkComponent<ElementType>>();
	return new Proxy(createArkElement, {
		apply(_target, _thisArg, args: [ElementType]) {
			return createArkElement(args[0]);
		},
		get(_target, property: string | symbol) {
			if (typeof property === 'symbol') return Reflect.get(_target, property);
			const element = property as ElementType;
			let component = cache.get(element);
			if (!component) {
				component = createArkElement(element);
				cache.set(element, component);
			}
			return component;
		},
	}) as typeof createArkElement & ArkElements;
}

export const ark = createArkFactory();
