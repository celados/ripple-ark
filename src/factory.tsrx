import { mergeProps } from '@zag-js/core';
import { type Children, type DynamicElementType } from 'ripple';

type ElementType = keyof JSX.IntrinsicElements;
type ParentProps<T extends ElementType> =
	(userProps?: JSX.IntrinsicElements[T]) => JSX.IntrinsicElements[T];
export type PolymorphicProps<T extends ElementType> = {
	asChild?: (props: ParentProps<T>) => Children;
};
export type HTMLProps<T extends ElementType> = JSX.IntrinsicElements[T];
export type HTMLArkProps<T extends ElementType> = HTMLProps<T> & PolymorphicProps<T>;

type ArkComponent<T extends ElementType> = (props: HTMLArkProps<T>) => Children;
type ArkElements = { [T in ElementType]: ArkComponent<T> };

function withAsProp<T extends ElementType>(tag: T): ArkComponent<T> {
	return function ArkComponent(props: HTMLArkProps<T>) @{
		let &{ asChild, ...parentProps } = props;
		@if (asChild) {
			const Content = () => asChild(
				(userProps = {}) => mergeProps(parentProps, userProps) as JSX.IntrinsicElements[T],
			);
			<{Content} />
		} @else {
			const dynamicTag: DynamicElementType = tag;
			<{dynamicTag} {...parentProps} />
		}
	};
}

function createArkFactory() {
	const cache = new Map<ElementType, ArkComponent<ElementType>>();
	return new Proxy(withAsProp, {
		apply(_target, _thisArg, args: [ElementType]) {
			return withAsProp(args[0]);
		},
		get(_target, property: string | symbol) {
			if (typeof property === 'symbol') return Reflect.get(_target, property);
			const element = property as ElementType;
			let component = cache.get(element);
			if (!component) {
				component = withAsProp(element);
				cache.set(element, component);
			}
			return component;
		},
	}) as typeof withAsProp & ArkElements;
}

export const ark = createArkFactory();
