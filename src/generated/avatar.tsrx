import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useAvatar } from '../components';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useAvatar;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = /*#__PURE__*/ new RippleContext<Tracked<Api> | null>(null);

export const Root = /*#__PURE__*/ createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'id',
		'ids',
		'onStatusChange',
	],

	useMachine: useAvatar as any,
});
export const RootProvider = /*#__PURE__*/ createRootProvider({ context, defaultTag: 'div' });
export const Fallback = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'span',
	getter: 'getFallbackProps',
});
export const Image = /*#__PURE__*/ createPart({
	context,
	defaultTag: 'img',
	getter: 'getImageProps',
});

export const Context = /*#__PURE__*/ createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type FallbackProps = ArkPartProps;
export type ImageProps = ArkPartProps;

export const Avatar = { Root, RootProvider, Fallback, Image, Context };
