import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAvatar } from '../components';
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
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function RootProvider(props: RootProviderProps) @{
	let &{ children } = props;
	const mergedProps = useRootProviderProps({ context }, props);
	<Part tag="div" merged={mergedProps} of={props}>{children}</Part>
}
export function Fallback(props: FallbackProps) @{
	let &{ children } = props;
	<Part tag="span" options={{ context, getter: 'getFallbackProps' }} of={props}>{children}</Part>
}
export function Image(props: ImageProps) @{
	<Part tag="img" options={{ context, getter: 'getImageProps' }} of={props} />
}

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps =
	ArkPartProps<'div'> & NonNullable<Parameters<Hook>[0]> & { render?: RenderProp<'div'> };
export type RootProviderProps =
	ArkPartProps<'div'> & { value: ReturnType<Hook> } & { render?: RenderProp<'div'> };
export type FallbackProps =
	(PartProps<'span', Api['getFallbackProps']>) & { render?: RenderProp<'span'> };
export type ImageProps = (PartProps<'img', Api['getImageProps']>) & { render?: RenderProp<'img'> };

export const Avatar = { Root, RootProvider, Fallback, Image, Context };
