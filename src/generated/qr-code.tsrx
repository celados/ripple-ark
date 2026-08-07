import { Context as RippleContext, effect, track, type Children, type Tracked } from 'ripple';

import { useQrCode } from '../components.ts';
import {
	createApiContext,
	createExternalPart,
	createItemContext,
	createPart,
	createRoot,
	createRootProvider,
	type ArkPartProps,
} from '../binding-runtime.tsrx';

type Hook = typeof useQrCode;
type Api = ReturnType<Hook>['value'];
type AnyRecord = Record<string, any>;

const context = new RippleContext<Tracked<Api> | null>(null);

export const Root = createRoot({
	context,
	defaultTag: 'div',
	configKeys: [
		'defaultValue',
		'encoding',
		'id',
		'ids',
		'onValueChange',
		'pixelSize',
		'value',
	],

	useMachine: useQrCode as any,
});
export const RootProvider = createRootProvider({ context, defaultTag: 'div' });
export const DownloadTrigger = createPart({
	context,
	defaultTag: 'button',
	getter: 'getDownloadTriggerProps',
	propKeys: [
		'fileName',
		'mimeType',
		'quality',
	],
});
export const Overlay = createPart({ context, defaultTag: 'div', getter: 'getOverlayProps' });
export const Frame = createPart({ context, defaultTag: 'svg', getter: 'getFrameProps' });
export const Pattern = createPart({ context, defaultTag: 'path', getter: 'getPatternProps' });

export const Context = createApiContext(context);

export type RootProps = ArkPartProps & NonNullable<Parameters<Hook>[0]>;
export type RootProviderProps = ArkPartProps & { value: ReturnType<Hook> };
export type DownloadTriggerProps = ArkPartProps;
export type OverlayProps = ArkPartProps;
export type FrameProps = ArkPartProps;
export type PatternProps = ArkPartProps;

export const QrCode = { Root, RootProvider, DownloadTrigger, Overlay, Frame, Pattern, Context };
