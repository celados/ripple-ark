import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAvatar } from '../components';
import {
	createApiContext,
	createItemContext,
	useExternalPartProps,
	usePartProps,
	useRootProps,
	useRootProviderProps,
	type ArkPartProps,
	type ComponentProps,
	type GetterProps,
	type PartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useAvatar;
export type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export function Root(props: RootProps) @{
	let &{ children } = props;
	const mergedProps = useRootProps(
		{
			context,
			configKeys: [
				'id',
				'ids',
				'onStatusChange',
			],

			useMachine: useAvatar as any,
		},
		props,
	);
	<div {...mergedProps.value}>{children}</div>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<div {...mergedProps.value}>{children}</div>
}
export function Fallback(props: FallbackProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getFallbackProps' }, props);
	<span {...mergedProps.value}>{children}</span>
}
export function Image(props: ImageProps) @{
	let &{ children } = props;
	const mergedProps = usePartProps({ context, getter: 'getImageProps' }, props);
	<img {...mergedProps.value} />
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps<'div'> & { value: ReturnType<Hook> };
export type FallbackProps = PartProps<'span', Api['getFallbackProps']>;
export type ImageProps = PartProps<'img', Api['getImageProps']>;

export const Avatar = { Root, RootProvider, Fallback, Image, Context };
